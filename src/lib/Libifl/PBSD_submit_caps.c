/*
*         OpenPBS (Portable Batch System) v2.3 Software License
*
* Copyright (c) 1999-2000 Veridian Information Solutions, Inc.
* All rights reserved.
*
* ---------------------------------------------------------------------------
* For a license to use or redistribute the OpenPBS software under conditions
* other than those described below, or to purchase support for this software,
* please contact Veridian Systems, PBS Products Department ("Licensor") at:
*
*    www.OpenPBS.org  +1 650 967-4675                  sales@OpenPBS.org
*                        877 902-4PBS (US toll-free)
* ---------------------------------------------------------------------------
*
* This license covers use of the OpenPBS v2.3 software (the "Software") at
* your site or location, and, for certain users, redistribution of the
* Software to other sites and locations.  Use and redistribution of
* OpenPBS v2.3 in source and binary forms, with or without modification,
* are permitted provided that all of the following conditions are met.
* After December 31, 2001, only conditions 3-6 must be met:
*
* 1. Commercial and/or non-commercial use of the Software is permitted
*    provided a current software registration is on file at www.OpenPBS.org.
*    If use of this software contributes to a publication, product, or
*    service, proper attribution must be given; see www.OpenPBS.org/credit.html
*
* 2. Redistribution in any form is only permitted for non-commercial,
*    non-profit purposes.  There can be no charge for the Software or any
*    software incorporating the Software.  Further, there can be no
*    expectation of revenue generated as a consequence of redistributing
*    the Software.
*
* 3. Any Redistribution of source code must retain the above copyright notice
*    and the acknowledgment contained in paragraph 6, this list of conditions
*    and the disclaimer contained in paragraph 7.
*
* 4. Any Redistribution in binary form must reproduce the above copyright
*    notice and the acknowledgment contained in paragraph 6, this list of
*    conditions and the disclaimer contained in paragraph 7 in the
*    documentation and/or other materials provided with the distribution.
*
* 5. Redistributions in any form must be accompanied by information on how to
*    obtain complete source code for the OpenPBS software and any
*    modifications and/or additions to the OpenPBS software.  The source code
*    must either be included in the distribution or be available for no more
*    than the cost of distribution plus a nominal fee, and all modifications
*    and additions to the Software must be freely redistributable by any party
*    (including Licensor) without restriction.
*
* 6. All advertising materials mentioning features or use of the Software must
*    display the following acknowledgment:
*
*     "This product includes software developed by NASA Ames Research Center,
*     Lawrence Livermore National Laboratory, and Veridian Information
*     Solutions, Inc.
*     Visit www.OpenPBS.org for OpenPBS software support,
*     products, and information."
*
* 7. DISCLAIMER OF WARRANTY
*
* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. ANY EXPRESS
* OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT
* ARE EXPRESSLY DISCLAIMED.
*
* IN NO EVENT SHALL VERIDIAN CORPORATION, ITS AFFILIATED COMPANIES, OR THE
* U.S. GOVERNMENT OR ANY OF ITS AGENCIES BE LIABLE FOR ANY DIRECT OR INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
* OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
* EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
* This license will be governed by the laws of the Commonwealth of Virginia,
* without reference to its choice of law rules.
*/
#include <pbs_config.h>   /* the master config generated by configure */

#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include "portability.h"
#include "libpbs.h"
#include "dis.h"
#include "u_hash_map_structs.h"
#include "u_memmgr.h"
#include "pbs_ifl.h"
#include "../lib/Libifl/lib_ifl.h"
#include "server_limits.h"

/* PBSD_submit.c

        PBSD_rdytocmt()

 This function does the Ready To Commit sub-function of
 the Queue Job request.
*/



int PBSD_rdytocmt(

  int   connect,
  char *jobid)

  {
  int                 rc;

  struct batch_reply *reply;
  int                 sock;
  struct tcp_chan *chan = NULL;
  
  if ((connect < 0) || 
      (connect >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  pthread_mutex_lock(connection[connect].ch_mutex);
  sock = connection[connect].ch_socket;
  pthread_mutex_unlock(connection[connect].ch_mutex);

  if ((chan = DIS_tcp_setup(sock)) == NULL)
    {
    return(PBSE_MEM_MALLOC);
    }
  else if ((rc = encode_DIS_ReqHdr(chan, PBS_BATCH_RdytoCommit, pbs_current_user)) ||
      (rc = encode_DIS_JobId(chan, jobid)) ||
      (rc = encode_DIS_ReqExtend(chan, NULL)))
    {
    pthread_mutex_lock(connection[connect].ch_mutex);
    connection[connect].ch_errtxt = strdup(dis_emsg[rc]);
    pthread_mutex_unlock(connection[connect].ch_mutex);
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }

  if (DIS_tcp_wflush(chan))
    {
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }
  DIS_tcp_cleanup(chan);

  /* read reply */

  reply = PBSD_rdrpy(&rc, connect);

  PBSD_FreeReply(reply);

  return(rc);
  }




int PBSD_commit_get_sid(

  int   connect, /* I */
  long *sid,     /* O */
  char *jobid)   /* I */

  {
  struct batch_reply *reply;
  int                 rc;
  int                 sock;
  int                 local_errno = 0;
  struct tcp_chan *chan = NULL;
  
  if ((connect < 0) || 
      (connect >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  pthread_mutex_lock(connection[connect].ch_mutex);
  sock = connection[connect].ch_socket;
  pthread_mutex_unlock(connection[connect].ch_mutex);

  if ((chan = DIS_tcp_setup(sock)) == NULL)
    {
    return(PBSE_MEM_MALLOC);
    }
  else if ((rc = encode_DIS_ReqHdr(chan, PBS_BATCH_Commit, pbs_current_user)) ||
           (rc = encode_DIS_JobId(chan, jobid)) ||
           (rc = encode_DIS_ReqExtend(chan, NULL)))
    {
    pthread_mutex_lock(connection[connect].ch_mutex);
    connection[connect].ch_errtxt = strdup(dis_emsg[rc]);
    pthread_mutex_unlock(connection[connect].ch_mutex);
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }

  if (DIS_tcp_wflush(chan))
    {
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }

  DIS_tcp_cleanup(chan);

  /* PBSD_rdrpy sets connection[connect].ch_errno */
  reply = PBSD_rdrpy(&local_errno, connect);

  pthread_mutex_lock(connection[connect].ch_mutex);
  rc = connection[connect].ch_errno;
  pthread_mutex_unlock(connection[connect].ch_mutex);

  if (reply == NULL)
    {
    /* couldn't read a response */
    if (rc == PBSE_NONE)
      rc = PBSE_PROTOCOL;
    }
  else
    {
    /* read the sid if given and no error */
    if (rc == PBSE_NONE)
      {
      if (reply->brp_choice == BATCH_REPLY_CHOICE_Text)
        {
        if (sid != NULL)
          *sid = atol(reply->brp_un.brp_txt.brp_str);
        }
      else
        /* (reply->brp_choice == BATCH_REPLY_CHOICE_NULL) */
        {
        *sid = reply->brp_code;
        }
      }
    
    PBSD_FreeReply(reply);
    }

  return(rc);
  } /* END PBSD_commit_get_sid() */





/* PBS_commit.c

 This function does the Commit sub-function of
 the Queue Job request.
*/

int PBSD_commit(

  int   connect,  /* I */
  char *jobid)    /* I */

  {

  struct batch_reply *reply;
  int                 rc;
  int                 sock;
  struct tcp_chan *chan = NULL;
  
  if ((connect < 0) || 
      (connect >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  pthread_mutex_lock(connection[connect].ch_mutex);
  sock = connection[connect].ch_socket;
  pthread_mutex_unlock(connection[connect].ch_mutex);

  if ((chan = DIS_tcp_setup(sock)) == NULL)
    {
    return(PBSE_MEM_MALLOC);
    }
  else if ((rc = encode_DIS_ReqHdr(chan, PBS_BATCH_Commit, pbs_current_user)) ||
      (rc = encode_DIS_JobId(chan, jobid)) ||
      (rc = encode_DIS_ReqExtend(chan, NULL)))
    {
    pthread_mutex_lock(connection[connect].ch_mutex);
    connection[connect].ch_errtxt = strdup(dis_emsg[rc]);
    pthread_mutex_unlock(connection[connect].ch_mutex);
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }

  if (DIS_tcp_wflush(chan))
    {
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }
  DIS_tcp_cleanup(chan);

  /* PBSD_rdrpy sets connection[connect].ch_errno */
  reply = PBSD_rdrpy(&rc, connect);

  PBSD_FreeReply(reply);
  return(rc);
  }  /* END PBSD_commit() */




/* PBS_scbuf.c
 *
 * Send a chunk of a of the job script to the server.
 * Called by pbs_submit.  The buffer length could be
 * zero; the server should handle that case...
*/

int PBSD_scbuf(

  int   c,  /* connection handle     */
  int   reqtype, /* request type */
  int   seq,  /* file chunk sequence number */
  char *buf,  /* file chunk */
  int   len,  /* length of chunk */
  char *jobid,  /* job id (for types 1 and 2 only) */
  enum job_file which) /* standard file type, see libpbs.h */

  {

  struct batch_reply *reply;

  int                 rc;
  int                 sock;
  int                 local_errno = 0;
  struct tcp_chan *chan = NULL;
  
  if ((c < 0) || 
      (c >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  pthread_mutex_lock(connection[c].ch_mutex);
  sock = connection[c].ch_socket;
  pthread_mutex_unlock(connection[c].ch_mutex);

  if ((chan = DIS_tcp_setup(sock)) == NULL)
    {
    return(PBSE_MEM_MALLOC);
    }
  else if (jobid == NULL)
    jobid = (char *)""; /* use null string for null pointer */

  if ((rc = encode_DIS_ReqHdr(chan, reqtype, pbs_current_user)) ||
      (rc = encode_DIS_JobFile(chan, seq, buf, len, jobid, which)) ||
      (rc = encode_DIS_ReqExtend(chan, NULL)))
    {
    pthread_mutex_lock(connection[c].ch_mutex);
    connection[c].ch_errtxt = strdup(dis_emsg[rc]);
    pthread_mutex_unlock(connection[c].ch_mutex);
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }

  if (DIS_tcp_wflush(chan))
    {
    DIS_tcp_cleanup(chan);
    return(PBSE_PROTOCOL);
    }
  DIS_tcp_cleanup(chan);

  /* read reply */

  reply = PBSD_rdrpy(&local_errno, c);

  PBSD_FreeReply(reply);

  pthread_mutex_lock(connection[c].ch_mutex);
  rc = connection[c].ch_errno;
  pthread_mutex_unlock(connection[c].ch_mutex);


  return(rc);
  }





/* PBS_jscript.c
 *
 * The Job Script subfunction of the Queue Job request
 * -- the function PBS_scbuf is called repeatedly to
 * transfer chunks of the script to the server.
*/

int PBSD_jscript(
    
  int   c,
  char *script_file,
  char *jobid)

  {
  int  i;
  int  fd;
  int  cc;
  int  rc;
  char s_buf[SCRIPT_CHUNK_Z];
  
  if ((c < 0) || 
      (c >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  if ((fd = open(script_file, O_RDONLY, 0)) < 0)
    {
    return (-1);
    }

  i = 0;

  cc = read_ac_socket(fd, s_buf, SCRIPT_CHUNK_Z);

  while ((cc > 0) && (PBSD_scbuf(c, PBS_BATCH_jobscript, i, s_buf, cc, jobid, JScript) == 0))
    {
    i++;
    cc = read_ac_socket(fd, s_buf, SCRIPT_CHUNK_Z);
    }

  close(fd);

  if (cc < 0) /* read failed */
    return (-1);

  pthread_mutex_lock(connection[c].ch_mutex);

  rc = connection[c].ch_errno;

  pthread_mutex_unlock(connection[c].ch_mutex);

  return(rc);
  }





/* PBS_jobfile.c
 *
 * The Job File function used to move files related to
 * a job between servers.
 * -- the function PBS_scbuf is called repeatedly to
 * transfer chunks of the script to the server.
*/

int PBSD_jobfile(

  int   c,
  int   req_type,
  char *path,
  char *jobid,
  enum job_file which)

  {
  int   i;
  int   cc;
  int   rc;
  int   fd;
  char  s_buf[SCRIPT_CHUNK_Z];
  
  if ((c < 0) || 
      (c >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  if (path[0] == '\0')
    return(PBSE_NONE);

  if ((fd = open(path, O_RDONLY, 0)) < 0)
    {
    return(-1);
    }

  i = 0;

  cc = read_ac_socket(fd, s_buf, SCRIPT_CHUNK_Z);

  while ((cc > 0) &&
         (PBSD_scbuf(c, req_type, i, s_buf, cc, jobid, which) == 0))
    {
    i++;

    cc = read_ac_socket(fd, s_buf, SCRIPT_CHUNK_Z);
    }

  close(fd);

  if (cc < 0) /* read failed */
    {
    return(-1);
    }

  pthread_mutex_lock(connection[c].ch_mutex);

  rc = connection[c].ch_errno;

  pthread_mutex_unlock(connection[c].ch_mutex);

  return(rc);
  }  /* END PBSD_jobfile() */




/* PBS_queuejob.c

 This function sends the first part of the Queue Job request
*/

char *PBSD_queuejob(

  int             connect,     /* I */
  int            *local_errno, /* O */
  char           *jobid,       /* I */
  char           *destin,
  struct attropl *attrib,
  char           *extend)

  {
  struct batch_reply *reply;
  char               *return_jobid = NULL;
  int                 rc;
  int                 sock;
  struct tcp_chan    *chan = NULL;
  
  if ((connect < 0) || 
      (connect >= PBS_NET_MAX_CONNECTIONS))
    {
    return(NULL);
    }

  pthread_mutex_lock(connection[connect].ch_mutex);
  sock = connection[connect].ch_socket;
  connection[connect].ch_errno = 0;
  pthread_mutex_unlock(connection[connect].ch_mutex);

  if ((chan = DIS_tcp_setup(sock)) == NULL)
    {
    return(NULL);
    }
  /* first, set up the body of the Queue Job request */
  else if ((rc = encode_DIS_ReqHdr(chan,PBS_BATCH_QueueJob,pbs_current_user)) ||
           (rc = encode_DIS_QueueJob(chan, jobid, destin, attrib)) ||
           (rc = encode_DIS_ReqExtend(chan, extend)))
    {
    pthread_mutex_lock(connection[connect].ch_mutex);
    connection[connect].ch_errtxt = strdup(dis_emsg[rc]);
    pthread_mutex_unlock(connection[connect].ch_mutex);

    *local_errno = PBSE_PROTOCOL;
    DIS_tcp_cleanup(chan);
    return(NULL);
    }

  if (DIS_tcp_wflush(chan))
    {
    *local_errno = PBSE_PROTOCOL;
    DIS_tcp_cleanup(chan);
    return(NULL);
    }

  DIS_tcp_cleanup(chan);

  /* read reply from stream into presentation element */

  reply = PBSD_rdrpy(local_errno, connect);

  pthread_mutex_lock(connection[connect].ch_mutex);
  if (reply == NULL)
    {
    }
  else if (reply->brp_choice &&
           reply->brp_choice != BATCH_REPLY_CHOICE_Text &&
           reply->brp_choice != BATCH_REPLY_CHOICE_Queue)
    {
    *local_errno = PBSE_PROTOCOL;
    }
  else if (connection[connect].ch_errno == 0)
    {
    return_jobid = strdup(reply->brp_un.brp_jid);
    }
  pthread_mutex_unlock(connection[connect].ch_mutex);

  PBSD_FreeReply(reply);

  return(return_jobid);
  }  /* END PBSD_queuejob() */




int PBSD_QueueJob_hash(

  int             connect,     /* I */
  char           *jobid,       /* I */
  char           *destin,
  memmgr        **mm,
  job_data       *job_attr,
  job_data       *res_attr,
  char           *extend,
  char          **job_id,
  char          **msg)

  {
  struct batch_reply *reply;
  int                 rc = PBSE_NONE;
  int                 sock;
  int                 tmp_size = 0;
  struct tcp_chan *chan = NULL;
  
  if ((connect < 0) || 
      (connect >= PBS_NET_MAX_CONNECTIONS))
    {
    return(PBSE_IVALREQ);
    }

  pthread_mutex_lock(connection[connect].ch_mutex);
  sock = connection[connect].ch_socket;
  pthread_mutex_unlock(connection[connect].ch_mutex);

  if ((chan = DIS_tcp_setup(sock)) == NULL)
    {
    return(PBSE_PROTOCOL);
    }
  /* first, set up the body of the Queue Job request */
  else if ((rc = encode_DIS_ReqHdr(chan, PBS_BATCH_QueueJob, pbs_current_user)) ||
           (rc = encode_DIS_QueueJob_hash(chan, jobid, destin, mm, job_attr, res_attr)) ||
           (rc = encode_DIS_ReqExtend(chan, extend)))
    {
    pthread_mutex_lock(connection[connect].ch_mutex);
    if (connection[connect].ch_errtxt == NULL)
      {
      if ((rc >= 0) &&
          (rc <= DIS_INVALID))
        connection[connect].ch_errtxt = memmgr_strdup(mm, (char *)dis_emsg[rc], &tmp_size);
      }
    *msg = memmgr_strdup(mm, connection[connect].ch_errtxt, &tmp_size);

    pthread_mutex_unlock(connection[connect].ch_mutex);

    DIS_tcp_cleanup(chan);

    return(rc);
    }

  if ((rc = DIS_tcp_wflush(chan)))
    {
    pthread_mutex_lock(connection[connect].ch_mutex);
    if (connection[connect].ch_errtxt == NULL)
      {
      *msg = memmgr_strdup(mm, connection[connect].ch_errtxt, &tmp_size);
      }
    pthread_mutex_unlock(connection[connect].ch_mutex);

    DIS_tcp_cleanup(chan);

    return(rc);
    }
    
  DIS_tcp_cleanup(chan);

  /* read reply from stream into presentation element */
  reply = PBSD_rdrpy(&rc, connect);

  pthread_mutex_lock(connection[connect].ch_mutex);
  if (reply == NULL)
    {
    if (rc == PBSE_TIMEOUT)
      rc = PBSE_EXPIRED;
    }
  else if (reply->brp_choice &&
           reply->brp_choice != BATCH_REPLY_CHOICE_Text &&
           reply->brp_choice != BATCH_REPLY_CHOICE_Queue)
    {
    rc = PBSE_PROTOCOL;
    
    if (connection[connect].ch_errtxt == NULL)
      {
      *msg = NULL;
      }
    }
  else if (reply->brp_choice == BATCH_REPLY_CHOICE_Text)
    {
    *msg = memmgr_strdup(mm, reply->brp_un.brp_txt.brp_str, &tmp_size);
    }
  else if (connection[connect].ch_errno == 0)
    {
    *job_id = memmgr_strdup(mm, reply->brp_un.brp_jid, &tmp_size);
    }
    
  pthread_mutex_unlock(connection[connect].ch_mutex);

  PBSD_FreeReply(reply);

  return rc;
  }  /* END PBSD_queuejob() */

/* END PBSD_submit.c */