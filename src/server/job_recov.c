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
/*
 * job_recov.c - This file contains the functions to record a job
 * data struture to disk and to recover it from disk.
 *
 * The data is recorded in a file whose name is the job_id.
 *
 * The following public functions are provided:
 *  job_save()   - save the disk image
 *  job_recov()  - recover (read) job from disk
 */

#include <pbs_config.h>   /* the master config generated by configure */

#include <pthread.h>

#include <sys/types.h>
#include <sys/param.h>
#include "pbs_ifl.h"
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include "server_limits.h"
#include "list_link.h"
#include "attribute.h"
#include "pbs_job.h"
#include "log.h"
#include "../lib/Liblog/pbs_log.h"
#include "../lib/Liblog/log_event.h"
#include "../lib/Libifl/lib_ifl.h"
#include "svrfunc.h"
#include "server.h"
#if __STDC__ != 1
#include <memory.h>
#endif
#ifndef PBS_MOM
#include "array.h"
#include "../lib/Libutils/u_lock_ctl.h" /* lock_ss, unlock_ss */
#include "job_func.h" /* job_free */
#else
#include "../resmom/mom_job_func.h" /* mom_job_free */
#endif
#include "array.h"
#include "ji_mutex.h"

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

#define JOBBUFSIZE 2048
#define MAX_SAVE_TRIES 3

#ifdef PBS_MOM
int save_tmsock(job *, int, char *, size_t *, size_t);
int recov_tmsock(int, job *);
extern unsigned int pbs_mom_port;
extern unsigned int pbs_rm_port;
extern int           multi_mom;
#endif

extern int job_qs_upgrade(job *, int, char *, int);

/* global data items */

extern char  *path_jobs;
extern const char *PJobSubState[];
extern int LOGLEVEL;

/* data global only to this file */

#ifndef PBS_MOM
int add_to_ms_list(char *node_name, job *pjob);
#endif

/*
 * job_save() - Saves (or updates) a job structure image on disk
 *
 * Save does either - a quick update for state changes only,
 *    - a full update for an existing file, or
 *    - a full write for a new job
 *
 * For a quick update, the data written is less than a disk block
 * size and no size change occurs; so it is rewritten in place.
 *
 * For a full update (usually following modify job request), to
 * insure no data is ever lost due to system crash:
 * 1. write new image to a new file using a temp name
 * 2. unlink the old (image) file
 * 3. link the correct name to the new file
 * 4. unlink the temp name
 *
 * For a new file write, first time, the data is written directly to
 * the file.
 *
 *      RETURN:  0 - success, -1 - failure
 */

int job_save(

  job *pjob,  /* pointer to job structure */
  int  updatetype, /* 0=quick, 1=full, 2=new     */
  int  mom_port)   /* if 0 ignore otherwise append to end of job name. this is for multi-mom mode */

  {
  int     fds;
  int     i;
  char    namebuf1[MAXPATHLEN];
  char    namebuf2[MAXPATHLEN];
  char    save_buf[SAVEJOB_BUF_SIZE];
  const char   *tmp_ptr = NULL;
  size_t  buf_remaining = sizeof(save_buf);

  int     openflags;
  int     redo;
  time_t  time_now = time(NULL);


#ifdef PBS_MOM
  tmp_ptr = JOB_FILE_SUFFIX;
#else
  if (pjob->ji_is_array_template == TRUE)
    tmp_ptr = (char *)JOB_FILE_TMP_SUFFIX;
  else
    tmp_ptr = (char *)JOB_FILE_SUFFIX;
#endif

  if (mom_port)
    {
    snprintf(namebuf1, MAXPATHLEN, "%s%s%d%s",
        path_jobs, pjob->ji_qs.ji_fileprefix, mom_port, tmp_ptr);
    snprintf(namebuf2, MAXPATHLEN, "%s%s%d%s",
        path_jobs, pjob->ji_qs.ji_fileprefix, mom_port, JOB_FILE_COPY);
    }
  else
    {
    snprintf(namebuf1, MAXPATHLEN, "%s%s%s",
        path_jobs, pjob->ji_qs.ji_fileprefix, tmp_ptr);
    snprintf(namebuf2, MAXPATHLEN, "%s%s%s",
        path_jobs, pjob->ji_qs.ji_fileprefix, JOB_FILE_COPY);
    }

  /* if ji_modified is set, ie an pbs_attribute changed, then update mtime */

  if (pjob->ji_modified)
    {
    pjob->ji_wattr[JOB_ATR_mtime].at_val.at_long = time_now;
    }

  if (updatetype == SAVEJOB_QUICK)
    {
    openflags = O_WRONLY | O_Sync;

    /* NOTE:  open, do not create */

    fds = open(namebuf1, openflags, 0600);

    if (fds < 0)
      {
      char tmpLine[1024];

      snprintf(tmpLine, sizeof(tmpLine), "cannot open file '%s' for job %s in state %s (%s)",
               namebuf1,
               pjob->ji_qs.ji_jobid,
               PJobSubState[MAX(0,pjob->ji_qs.ji_substate)],
               (updatetype == 0) ? "quick" : "full");

      log_err(errno, "job_save", tmpLine);

      /* FAILURE */

      return(-1);
      }

    /* just write the "critical" base structure to the file */

    while ((i = write_ac_socket(fds, (char *)&pjob->ji_qs, sizeof(pjob->ji_qs))) != sizeof(pjob->ji_qs))
      {
      if ((i < 0) && (errno == EINTR))
        {
        /* retry the write */

        if (lseek(fds, (off_t)0, SEEK_SET) < 0)
          {
          log_err(errno, "job_save", (char *)"lseek");

          close(fds);

          return(-1);
          }

        continue;
        }
      else
        {
        log_err(errno, "job_save", (char *)"quickwrite");

        close(fds);

        /* FAILURE */

        return(-1);
        }
      }

    close(fds);
    }
  else /* SAVEJOB_FULL, SAVEJOB_NEW, SAVEJOB_ARY */
    {
    /*
     * write the whole structure to the file.
     * For a update, this is done to a new file to protect the
     * old against crashs.
     * The file is written in four parts:
     * (1) the job structure,
     * (2) the attribtes in "encoded" form,
     * (3) the attributes in the "external" form, and last
     * (4) the dependency list.
     */

    openflags = O_CREAT | O_WRONLY | O_Sync;

    /* NOTE:  create file if required */

    if (updatetype == SAVEJOB_NEW)
      fds = open(namebuf1, openflags, 0600);
    else
      fds = open(namebuf2, openflags, 0600);

    if (fds < 0)
      {
      log_err(errno, "job_save", (char *)"open for full save");

      return(-1);
      }

    for (i = 0; i < MAX_SAVE_TRIES; i++)
      {
      redo = 0; /* try to save twice */

#ifndef PBS_MOM
      lock_ss();
#endif

      if (save_struct((char *)&pjob->ji_qs, sizeof(pjob->ji_qs), fds, save_buf, &buf_remaining, sizeof(save_buf)) != PBSE_NONE)
        {
        redo++;
        }
      else if (save_attr(job_attr_def,
            pjob->ji_wattr,
            JOB_ATR_LAST,
            fds,
            save_buf,
            &buf_remaining,
            sizeof(save_buf)) != PBSE_NONE)
        {
        redo++;
        }

#ifdef PBS_MOM
      else if (save_tmsock(pjob, fds, save_buf, &buf_remaining, sizeof(save_buf)) != PBSE_NONE)
        {
        redo++;
        }

#endif  /* PBS_MOM */
      else if (write_buffer(save_buf, sizeof(save_buf) - buf_remaining, fds) != PBSE_NONE)
        {
        redo++;
        }

#ifndef PBS_MOM
      unlock_ss();
#endif

      if (redo != 0)
        {
        if (lseek(fds, (off_t)0, SEEK_SET) < 0)
          {
          log_err(errno, "job_save", (char *)"full lseek");
          }
        }
      else
        {
        break;
        }
      }  /* END for (i) */

    /* Some write() errors may not show up until the close() */
    if((close(fds)) != 0)
      {
      if (updatetype == SAVEJOB_FULL)
        unlink(namebuf2);

      return(-1);
      }

    if (i >= MAX_SAVE_TRIES)
      {
      if (updatetype == SAVEJOB_FULL)
        unlink(namebuf2);

      return(-1);
      }

    if (updatetype == SAVEJOB_FULL)
      {
      unlink(namebuf1);

      if (link(namebuf2, namebuf1) == -1)
        {
        log_event(
          PBSEVENT_ERROR | PBSEVENT_SECURITY,
          PBS_EVENTCLASS_JOB,
          pjob->ji_qs.ji_jobid,
          (char *)"Link in job_save failed");
        }
      else
        {
        unlink(namebuf2);
        }
      }

    pjob->ji_modified = 0;
    }  /* END (updatetype == SAVEJOB_QUICK) */

  return(PBSE_NONE);
  }  /* END job_save() */





/*
 * job_recov() - recover (read in) a job from its save file
 *
 * This function is only needed upon server start up.
 *
 * The job structure, its attributes strings, and its dependencies
 * are recovered from the disk.  Space to hold the above is
 * calloc-ed as needed.
 *
 * Returns: job pointer to new job structure or a
 *   null pointer on an error.
*/

job *job_recov(

  char *filename) /* I */   /* pathname to job save file */

  {
  int  fds;
  job  *pj;
  char *pn;
  char  namebuf[MAXPATHLEN];
  char  log_buf[LOCAL_LOG_BUF_SIZE];

#ifndef PBS_MOM
  char       parent_id[PBS_MAXSVRJOBID + 1];
  job_array *pa;
#else
  char      fileid[MAXPATHLEN];
#endif

  pj = job_alloc(); /* allocate & initialize job structure space */

  if (pj == NULL)
    {
    /* FAILURE - cannot alloc memory */

    return(NULL);
    }

  snprintf(namebuf, MAXPATHLEN, "%s%s", path_jobs, filename); /* job directory path, filename */

  fds = open(namebuf, O_RDONLY, 0);

  if (fds < 0)
    {
    snprintf(log_buf, LOCAL_LOG_BUF_SIZE, "unable to open %s", namebuf);

    log_err(errno, __func__, log_buf);

#ifndef PBS_MOM
    unlock_ji_mutex(pj, __func__, "1", LOGLEVEL);
    free(pj->ji_mutex);
#endif

    free((char *)pj);

    /* FAILURE - cannot open job file */

    return(NULL);
    }

  /* read in job quick save sub-structure */

  if (read_ac_socket(fds, (char *)&pj->ji_qs, sizeof(pj->ji_qs)) != sizeof(pj->ji_qs) &&
      pj->ji_qs.qs_version == PBS_QS_VERSION)
    {
    snprintf(log_buf, LOCAL_LOG_BUF_SIZE, "Unable to read %s", namebuf);

    log_err(errno, __func__, log_buf);

#ifndef PBS_MOM
    unlock_ji_mutex(pj, __func__, "2", LOGLEVEL);
    free(pj->ji_mutex);
#endif

    free((char *)pj);

    close(fds);

    return(NULL);
    }

  /* is ji_qs the version we expect? */

  if (pj->ji_qs.qs_version != PBS_QS_VERSION)
    {
    /* ji_qs is older version */
    snprintf(log_buf, LOCAL_LOG_BUF_SIZE,
      "%s appears to be from an old version. Attempting to convert.\n",
      namebuf);

    log_err(-1, __func__, log_buf);

    if (job_qs_upgrade(pj, fds, namebuf, pj->ji_qs.qs_version) != 0)
      {
      snprintf(log_buf, LOCAL_LOG_BUF_SIZE, "unable to upgrade %s\n", namebuf);

      log_err(-1, __func__, log_buf);

#ifndef PBS_MOM
      unlock_ji_mutex(pj, __func__, "3", LOGLEVEL);
      free(pj->ji_mutex);
#endif

      free((char *)pj);

      close(fds);

      return(NULL);
      }

    }  /* END if (pj->ji_qs.qs_version != PBS_QS_VERSION) */

  /* Does file name match the internal name? */
  /* This detects ghost files */

  pn = strrchr(namebuf, (int)'/') + 1;

#ifndef PBS_MOM
  if (strncmp(pn, pj->ji_qs.ji_fileprefix, strlen(pj->ji_qs.ji_fileprefix)) != 0)
#else
  if(multi_mom != 0)
    {
    sprintf(fileid,"%s%d",pj->ji_qs.ji_fileprefix,pbs_rm_port);
    }
  else
    {
    strcpy(fileid,pj->ji_qs.ji_fileprefix);
    }
  if (strncmp(pn, fileid, strlen(fileid)) != 0)
#endif
    {
    /* mismatch, discard job */

    snprintf(log_buf, LOCAL_LOG_BUF_SIZE, "Job Id %s does not match file name for %s",
      pj->ji_qs.ji_jobid,
      namebuf);

    log_err(-1, __func__, log_buf);

#ifndef PBS_MOM
    unlock_ji_mutex(pj, __func__, "4", LOGLEVEL);
    free(pj->ji_mutex);
#endif

    free((char *)pj);

    close(fds);

    return(NULL);
    }

  /* read in working attributes */

  if (recov_attr(
        fds,
        pj,
        job_attr_def,
        pj->ji_wattr,
        JOB_ATR_LAST,
        JOB_ATR_UNKN,
        TRUE) != 0) 
    {
    snprintf(log_buf, LOCAL_LOG_BUF_SIZE, "unable to recover %s (file is likely corrupted)", namebuf);

    log_err(-1, __func__, log_buf);

#ifndef PBS_MOM
    unlock_ji_mutex(pj, __func__, "5", LOGLEVEL);
    job_free(pj, FALSE);
#else
    mom_job_free(pj);
#endif


    close(fds);

    return(NULL);
    }

#ifndef PBS_MOM
  /* Comment out the mother superior tracking. Will be debugged later 
  if (pj->ji_wattr[JOB_ATR_exec_host].at_val.at_str != NULL)
    {*/
    /* add job to the mother superior list for it's node */
/*    char *ms = strdup(pj->ji_wattr[JOB_ATR_exec_host].at_val.at_str);
    char *end = strchr(ms, '/');

    if (end != NULL)
      *end = '\0';

    if ((end = strchr(ms, '+')) != NULL)
      *end = '\0';

    add_to_ms_list(ms, pj);

    free(ms);
    }*/
#endif

#ifdef PBS_MOM
  /* read in tm sockets and ips */

  if (recov_tmsock(fds, pj) != 0)
    {
    snprintf(log_buf, LOCAL_LOG_BUF_SIZE,
        "warning: tmsockets not recovered from %s (written by an older pbs_mom?)",
        namebuf);

    log_err(-1, __func__, log_buf);
    }

#else /* not PBS_MOM */

  if (strchr(pj->ji_qs.ji_jobid, '[') != NULL)
    {
    /* job is part of an array.  We need to put a link back to the server
    job array struct for this array. We also have to link this job into
    the linked list of jobs belonging to the array. */

    array_get_parent_id(pj->ji_qs.ji_jobid, parent_id);
    pa = get_array(parent_id);
    if (pa == NULL)
      {   
      job_abt(&pj, (char *)"Array job missing array struct, aborting job");
      close(fds);
      return NULL;
      }

    strcpy(pj->ji_arraystructid, parent_id);

    if (strcmp(parent_id, pj->ji_qs.ji_jobid) == 0)
      {
      pj->ji_is_array_template = TRUE;
      }
    else
      {
      pa->job_ids[(int)pj->ji_wattr[JOB_ATR_job_array_id].at_val.at_long] = strdup(pj->ji_qs.ji_jobid);
      pa->jobs_recovered++;

      /* This is a bit of a kluge, but for some reason if an array job was 
         on hold when the server went down the ji_wattr[JOB_ATR_hold].at_val.at_long
         value is 0 on recovery even though pj->ji_qs.ji_state is JOB_STATE_HELD and
         the substate is JOB_SUBSTATE_HELD
      */
      if ((pj->ji_qs.ji_state == JOB_STATE_HELD) &&
          (pj->ji_qs.ji_substate == JOB_SUBSTATE_HELD))
        {
        pj->ji_wattr[JOB_ATR_hold].at_val.at_long = HOLD_l;
        pj->ji_wattr[JOB_ATR_hold].at_flags = ATR_VFLAG_SET;
        }
      }

    if (pa != NULL)
      {
      unlock_ai_mutex(pa, __func__, "1", LOGLEVEL);
      }
    }

#endif

  close(fds);

  pj->ji_commit_done = 1;

  /* all done recovering the job */

#ifdef PBS_MOM
  job_save(pj, SAVEJOB_FULL, (multi_mom == 0)?0:pbs_rm_port);
#else
  job_save(pj, SAVEJOB_FULL, 0);
#endif

  return(pj);
  }  /* END job_recov() */

/* END job_recov.c */



