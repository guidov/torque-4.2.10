# Makefile.in generated by automake 1.11.1 from Makefile.am.
# Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
# 2003, 2004, 2005, 2006, 2007, 2008, 2009  Free Software Foundation,
# Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.




pkgdatadir = $(datadir)/torque
pkgincludedir = $(includedir)/torque
pkglibdir = $(libdir)/torque
pkglibexecdir = $(libexecdir)/torque
am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
install_sh_DATA = $(install_sh) -c -m 644
install_sh_PROGRAM = $(install_sh) -c
install_sh_SCRIPT = $(install_sh) -c
INSTALL_HEADER = $(INSTALL_DATA)
transform = $(program_transform_name)
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
build_triplet = x86_64-unknown-linux-gnu
host_triplet = x86_64-unknown-linux-gnu
DIST_COMMON = $(am__configure_deps) $(srcdir)/Makefile.am \
	$(srcdir)/Makefile.in $(top_srcdir)/buildutils/config.mk \
	$(top_srcdir)/buildutils/modulefiles.in \
	$(top_srcdir)/buildutils/modulefiles.vers.in \
	$(top_srcdir)/buildutils/pbs_mkdirs.in \
	$(top_srcdir)/buildutils/self-extract-head-sh.in \
	$(top_srcdir)/buildutils/torque.spec.in \
	$(top_srcdir)/configure INSTALL buildutils/compile \
	buildutils/config.guess buildutils/config.sub \
	buildutils/depcomp buildutils/install-sh buildutils/ltmain.sh \
	buildutils/missing buildutils/ylwrap
subdir = .
ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
am__aclocal_m4_deps = $(top_srcdir)/acinclude.m4 \
	$(top_srcdir)/buildutils/tcl.m4 \
	$(top_srcdir)/buildutils/ac_create_generic_config.m4 \
	$(top_srcdir)/buildutils/acx_pthread.m4 \
	$(top_srcdir)/buildutils/ax_prog_dot.m4 \
	$(top_srcdir)/buildutils/ac_c_bigendian_cross.m4 \
	$(top_srcdir)/buildutils/t_add_rpath.m4 \
	$(top_srcdir)/buildutils/tac_tcltk.m4 \
	$(top_srcdir)/buildutils/ax_cflags_gcc_option.m4 \
	$(top_srcdir)/configure.ac
am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
	$(ACLOCAL_M4)
am__CONFIG_DISTCLEAN_FILES = config.status config.cache config.log \
 configure.lineno config.status.lineno
mkinstalldirs = $(install_sh) -d
CONFIG_HEADER = $(top_builddir)/src/include/pbs_config.h
CONFIG_CLEAN_FILES = torque.spec buildutils/pbs_mkdirs \
	buildutils/self-extract-head-sh buildutils/modulefiles \
	buildutils/modulefiles.vers
CONFIG_CLEAN_VPATH_FILES =
am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
am__vpath_adj = case $$p in \
    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
    *) f=$$p;; \
  esac;
am__strip_dir = f=`echo $$p | sed -e 's|^.*/||'`;
am__install_max = 40
am__nobase_strip_setup = \
  srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*|]/\\\\&/g'`
am__nobase_strip = \
  for p in $$list; do echo "$$p"; done | sed -e "s|$$srcdirstrip/||"
am__nobase_list = $(am__nobase_strip_setup); \
  for p in $$list; do echo "$$p $$p"; done | \
  sed "s| $$srcdirstrip/| |;"' / .*\//!s/ .*/ ./; s,\( .*\)/[^/]*$$,\1,' | \
  $(AWK) 'BEGIN { files["."] = "" } { files[$$2] = files[$$2] " " $$1; \
    if (++n[$$2] == $(am__install_max)) \
      { print $$2, files[$$2]; n[$$2] = 0; files[$$2] = "" } } \
    END { for (dir in files) print dir, files[dir] }'
am__base_list = \
  sed '$$!N;$$!N;$$!N;$$!N;$$!N;$$!N;$$!N;s/\n/ /g' | \
  sed '$$!N;$$!N;$$!N;$$!N;s/\n/ /g'
am__installdirs = "$(DESTDIR)$(bindir)"
SCRIPTS = $(bin_SCRIPTS)
AM_V_GEN = $(am__v_GEN_$(V))
am__v_GEN_ = $(am__v_GEN_$(AM_DEFAULT_VERBOSITY))
am__v_GEN_0 = @echo "  GEN   " $@;
AM_V_at = $(am__v_at_$(V))
am__v_at_ = $(am__v_at_$(AM_DEFAULT_VERBOSITY))
am__v_at_0 = @
SOURCES =
DIST_SOURCES =
RECURSIVE_TARGETS = all-recursive check-recursive dvi-recursive \
	html-recursive info-recursive install-data-recursive \
	install-dvi-recursive install-exec-recursive \
	install-html-recursive install-info-recursive \
	install-pdf-recursive install-ps-recursive install-recursive \
	installcheck-recursive installdirs-recursive pdf-recursive \
	ps-recursive uninstall-recursive
RECURSIVE_CLEAN_TARGETS = mostlyclean-recursive clean-recursive	\
  distclean-recursive maintainer-clean-recursive
AM_RECURSIVE_TARGETS = $(RECURSIVE_TARGETS:-recursive=) \
	$(RECURSIVE_CLEAN_TARGETS:-recursive=) tags TAGS ctags CTAGS \
	distdir dist dist-all distcheck
ETAGS = etags
CTAGS = ctags
DIST_SUBDIRS = $(SUBDIRS)
DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
distdir = $(PACKAGE)-$(VERSION)
top_distdir = $(distdir)
am__remove_distdir = \
  { test ! -d "$(distdir)" \
    || { find "$(distdir)" -type d ! -perm -200 -exec chmod u+w {} ';' \
         && rm -fr "$(distdir)"; }; }
am__relativize = \
  dir0=`pwd`; \
  sed_first='s,^\([^/]*\)/.*$$,\1,'; \
  sed_rest='s,^[^/]*/*,,'; \
  sed_last='s,^.*/\([^/]*\)$$,\1,'; \
  sed_butlast='s,/*[^/]*$$,,'; \
  while test -n "$$dir1"; do \
    first=`echo "$$dir1" | sed -e "$$sed_first"`; \
    if test "$$first" != "."; then \
      if test "$$first" = ".."; then \
        dir2=`echo "$$dir0" | sed -e "$$sed_last"`/"$$dir2"; \
        dir0=`echo "$$dir0" | sed -e "$$sed_butlast"`; \
      else \
        first2=`echo "$$dir2" | sed -e "$$sed_first"`; \
        if test "$$first2" = "$$first"; then \
          dir2=`echo "$$dir2" | sed -e "$$sed_rest"`; \
        else \
          dir2="../$$dir2"; \
        fi; \
        dir0="$$dir0"/"$$first"; \
      fi; \
    fi; \
    dir1=`echo "$$dir1" | sed -e "$$sed_rest"`; \
  done; \
  reldir="$$dir2"
DIST_ARCHIVES = $(distdir).tar.gz
GZIP_ENV = --best
distuninstallcheck_listfiles = find . -type f -print
distcleancheck_listfiles = find . -type f -print
ACLOCAL = ${SHELL} /home/guido/git/torque-4.2.10/buildutils/missing aclocal-1.15
ALPS_LIBS = 
AMTAR = $${TAR-tar}
AM_DEFAULT_VERBOSITY = 1
AR = ar
AUTOCONF = ${SHELL} /home/guido/git/torque-4.2.10/buildutils/missing autoconf
AUTOHEADER = ${SHELL} /home/guido/git/torque-4.2.10/buildutils/missing autoheader
AUTOMAKE = ${SHELL} /home/guido/git/torque-4.2.10/buildutils/missing automake-1.15
AWK = gawk
BLCR_BINDIR = 
BLCR_CPPFLAGS = 
BLCR_LDFLAGS = 
CC = g++
CCDEPMODE = depmode=gcc3
CCLD = g++
CFLAGS = -g -D_LARGEFILE64_SOURCE
CHECK_CFLAGS = 
CHECK_LIBS = 
CPP = gcc -E
CPPFLAGS = 
CXX = g++
CXXCPP = g++ -E
CXXDEPMODE = depmode=gcc3
CXXFLAGS = -g -O2
CYGPATH = echo
CYGPATH_W = echo
DEFS = -DHAVE_CONFIG_H
DEPDIR = .deps
DOXYGEN = none
DSYMUTIL = 
DUMPBIN = 
ECHO_C = 
ECHO_N = -n
ECHO_T = 
EGREP = /bin/grep -E
EXEEXT = 
EXTRA_QSTAT_LIBS = $(EXTRA_QSTAT_LIBS)
FGREP = /bin/grep -F
GENERIC_CONFIG = pbs-config
GPERF = 
GREP = /bin/grep
HAVE_CR_RESTART = 
HAVE_DOT = 
HWLOC_CFLAGS = 
HWLOC_LIBS = 
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
LD = /usr/bin/ld -m elf_x86_64
LDFLAGS = 
LEX = flex
LEXLIB = 
LEX_OUTPUT_ROOT = lex.yy
LIBOBJS = 
LIBS = -lxml2 -lcrypto -lssl   -lpthread -lrt
LIBTOOL = $(SHELL) $(top_builddir)/libtool
LIBTOOLFLAGS = --tag=CXX
LIBTOOL_DEPS = buildutils/ltmain.sh
LIPO = 
LN_S = ln -s
LTLIBOBJS = 
MAINT = #
MAKE = make
MAKEINFO = ${SHELL} /home/guido/git/torque-4.2.10/buildutils/missing makeinfo
MKDIR_P = /bin/mkdir -p
MODULEFILES_DIR = no
MOMLIBS =  -lutil
MY_TCLTK_INCS =  -I/usr/include/tcl8.6/tcl-private/generic -I/usr/include/tcl8.6/tk-private/generic 
MY_TCLTK_LIBS =  -L/usr/lib/x86_64-linux-gnu -ltk8.6 -lX11 -lXss -lXext -L/usr/lib/x86_64-linux-gnu -ltcl8.6 -ldl -lz -lpthread -lieee -lm
MY_TCL_INCS =  -I/usr/include/tcl8.6/tcl-private/generic
MY_TCL_LIBS =  -L/usr/lib/x86_64-linux-gnu -ltcl8.6 -ldl -lz -lpthread -lieee -lm
NM = /usr/bin/nm -B
NMEDIT = 
OBJDUMP = objdump
OBJEXT = o
OTOOL = 
OTOOL64 = 
PACKAGE = torque
PACKAGE_BUGREPORT = torqueusers@supercluster.org
PACKAGE_NAME = torque
PACKAGE_STRING = torque 4.2.10
PACKAGE_TARNAME = torque
PACKAGE_VERSION = 4.2.10
PATH_SEPARATOR = :
PBSPOE = 
PBSPOEO = 
PBS_DEFAULT_FILE = ${PBS_SERVER_HOME}/server_name
PBS_DEFAULT_SERVER = aqua
PBS_ENVIRON = ${PBS_SERVER_HOME}/pbs_environment
PBS_MACH = linux
PBS_SERVER_HOME = /var/spool/torque
PIC = gpic
PKG_CONFIG = /usr/bin/pkg-config
PTHREAD_CFLAGS = 
PTHREAD_LIBS =  -lpthread -lrt
RANLIB = ranlib
RCP_ARGS = -rpB
RCP_PATH = /usr/bin/scp
READLINE_LIBS = -lncurses -lreadline
ROFF = groff
RPM_AC_OPTS =  --without munge --with syslog --with scp --without pam --without drmaa
RSH_PATH = ssh
SCHD_CODE = fifo
SCHD_LIBS = 
SCHD_TYPE = cc
SCHD_TYPE_SUBDIR = scheduler.cc
SED = /bin/sed
SENDMAIL_CMD = /usr/lib/sendmail
SET_MAKE = 
SHELL = /bin/bash
SPEC_NAME = torque
SPEC_VERSION = 4.2.10
STRIP = strip
TBL = gtbl
TCLSH_PROG = /usr/bin/tclsh8.6
TCL_BIN_DIR = /usr/lib/x86_64-linux-gnu
TCL_DEFS = -DPACKAGE_NAME=\"tcl\" -DPACKAGE_TARNAME=\"tcl\" -DPACKAGE_VERSION=\"8.6\" -DPACKAGE_STRING=\"tcl\ 8.6\" -DPACKAGE_BUGREPORT=\"\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_LIMITS_H=1 -DHAVE_SYS_PARAM_H=1 -DUSE_THREAD_ALLOC=1 -D_REENTRANT=1 -D_THREAD_SAFE=1 -DHAVE_PTHREAD_ATTR_SETSTACKSIZE=1 -DHAVE_PTHREAD_ATFORK=1 -DTCL_THREADS=1 -DTCL_CFGVAL_ENCODING=\"iso8859-1\" -DHAVE_ZLIB=1 -DMODULE_SCOPE=extern -DHAVE_CAST_TO_UNION=1 -DTCL_SHLIB_EXT=\".so\" -DNDEBUG=1 -DTCL_CFG_OPTIMIZED=1 -DTCL_TOMMATH=1 -DMP_PREC=4 -D_LARGEFILE64_SOURCE=1 -DTCL_WIDE_INT_IS_LONG=1 -DHAVE_GETCWD=1 -DHAVE_MKSTEMP=1 -DHAVE_OPENDIR=1 -DHAVE_STRTOL=1 -DHAVE_WAITPID=1 -DHAVE_GETNAMEINFO=1 -DHAVE_GETADDRINFO=1 -DHAVE_FREEADDRINFO=1 -DHAVE_GAI_STRERROR=1 -DHAVE_STRUCT_ADDRINFO=1 -DHAVE_STRUCT_IN6_ADDR=1 -DHAVE_STRUCT_SOCKADDR_IN6=1 -DHAVE_STRUCT_SOCKADDR_STORAGE=1 -DHAVE_GETPWUID_R_5=1 -DHAVE_GETPWUID_R=1 -DHAVE_GETPWNAM_R_5=1 -DHAVE_GETPWNAM_R=1 -DHAVE_GETGRGID_R_5=1 -DHAVE_GETGRGID_R=1 -DHAVE_GETGRNAM_R_5=1 -DHAVE_GETGRNAM_R=1 -DHAVE_GETHOSTBYNAME_R_6=1 -DHAVE_GETHOSTBYNAME_R=1 -DHAVE_GETHOSTBYADDR_R_8=1 -DHAVE_GETHOSTBYADDR_R=1 -DHAVE_TERMIOS_H=1 -DHAVE_SYS_IOCTL_H=1 -DHAVE_SYS_TIME_H=1 -DTIME_WITH_SYS_TIME=1 -DHAVE_GMTIME_R=1 -DHAVE_LOCALTIME_R=1 -DHAVE_MKTIME=1 -DHAVE_TM_GMTOFF=1 -DHAVE_TIMEZONE_VAR=1 -DHAVE_STRUCT_STAT_ST_BLOCKS=1 -DHAVE_STRUCT_STAT_ST_BLKSIZE=1 -DHAVE_BLKCNT_T=1 -DHAVE_INTPTR_T=1 -DHAVE_UINTPTR_T=1 -DHAVE_SIGNED_CHAR=1 -DHAVE_LANGINFO=1 -DHAVE_MKSTEMPS=1 -DHAVE_FTS=1 -DHAVE_SYS_IOCTL_H=1 -DTCL_UNLOAD_DLLS=1 -DHAVE_CPUID=1 
TCL_EXTRA_CFLAGS = -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -fno-unit-at-a-time -pipe -fvisibility=hidden -D_FORTIFY_SOURCE=2
TCL_INCLUDES = -I/usr/include/tcl8.6/tcl-private/generic
TCL_LD_FLAGS = -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--export-dynamic 
TCL_LIBS = -ldl -lz  -lpthread -lieee -lm
TCL_LIB_FILE = libtcl8.6.so
TCL_LIB_FLAG = -ltcl8.6
TCL_LIB_SPEC = -L/usr/lib/x86_64-linux-gnu -ltcl8.6
TCL_SHLIB_LD_LIBS = ${LIBS}
TCL_SRC_DIR = /usr/include/tcl8.6/tcl-private
TCL_STUB_LIB_FILE = libtclstub8.6.a
TCL_STUB_LIB_FLAG = -ltclstub8.6
TCL_STUB_LIB_SPEC = -L/usr/lib/x86_64-linux-gnu -ltclstub8.6
TCL_VERSION = 8.6
TK_BIN_DIR = /usr/lib/x86_64-linux-gnu
TK_INCLUDES = -I/usr/include/tcl8.6/tk-private/generic
TK_LIBS = -lX11 -lXss -lXext -lXft -lfontconfig -lfreetype    -lpthread -ldl -lz  -lpthread -lieee -lm
TK_LIB_FILE = libtk8.6.so
TK_LIB_FLAG = -ltk8.6
TK_LIB_SPEC = -L/usr/lib/x86_64-linux-gnu -ltk8.6
TK_SRC_DIR = /usr/include/tcl8.6/tk-private
TK_STUB_LIB_FILE = libtkstub8.6.a
TK_STUB_LIB_FLAG = -ltkstub8.6
TK_STUB_LIB_SPEC = -L/usr/lib/x86_64-linux-gnu -ltkstub8.6
TK_VERSION = 8.6
TK_XINCLUDES = 
VERSION = 4.2.10
WISH_PROG = /usr/bin/wish8.6
YACC = bison -y
YFLAGS = 
abs_builddir = /home/guido/git/torque-4.2.10
abs_srcdir = /home/guido/git/torque-4.2.10
abs_top_builddir = /home/guido/git/torque-4.2.10
abs_top_srcdir = /home/guido/git/torque-4.2.10
ac_ct_CC = gcc
ac_ct_CXX = g++
ac_ct_DUMPBIN = 
acx_pthread_config = 
am__include = include
am__leading_dot = .
am__quote = 
am__tar = $${TAR-tar} chof - "$$tardir"
am__untar = $${TAR-tar} xf -
bindir = ${exec_prefix}/bin
build = x86_64-unknown-linux-gnu
build_alias = 
build_clients = yes
build_cpu = x86_64
build_drmaa = no
build_drmaa_docs = no
build_gui = yes
build_mom = yes
build_os = linux-gnu
build_pbs_rcp = no
build_server = yes
build_vendor = unknown
builddir = .
datadir = ${datarootdir}
datarootdir = ${prefix}/share
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
drmaadocdir = ${datarootdir}/doc/torque-drmaa
dvidir = ${docdir}
exec_prefix = /usr/local/torque
have_loadlibfile = no
host = x86_64-unknown-linux-gnu
host_alias = 
host_cpu = x86_64
host_os = linux-gnu
host_vendor = unknown
htmldir = ${docdir}
includedir = ${prefix}/include
infodir = ${datarootdir}/info
install_sh = ${SHELL} /home/guido/git/torque-4.2.10/buildutils/install-sh
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/libexec
localedir = ${datarootdir}/locale
localstatedir = ${prefix}/var
lt_ECHO = @lt_ECHO@
mandir = ${datarootdir}/man
mkdir_p = $(MKDIR_P)
oldincludedir = /usr/include
pammoddir = disabled
pdfdir = ${docdir}
prefix = /usr/local/torque
program_prefix = 
program_suffix = 
program_transform_name = s,x,x,
psdir = ${docdir}
sbindir = ${exec_prefix}/sbin
sharedstatedir = ${prefix}/com
srcdir = .
sysconfdir = ${prefix}/etc
target_alias = 
tclx_LIB_FILE = 
tclx_LIB_SPEC = 
tclx_SRC_DIR = 
tclx_STUB_LIB_FILE = 
tclx_STUB_LIB_PATH = 
tclx_STUB_LIB_SPEC = 
tclx_VERSION = 
tkx_LIB_FILE = 
tkx_LIB_SPEC = 
tkx_SRC_DIR = 
tkx_STUB_LIB_FILE = 
tkx_STUB_LIB_PATH = 
tkx_STUB_LIB_SPEC = 
tkx_VERSION = 
top_build_prefix = 
top_builddir = .
top_srcdir = .
use_tcl = 1
use_tk = 1
xauth_path = /usr/bin/xauth
AUTOMAKE_OPTIONS = foreign
PBS_MKDIRS = $(SHELL) $(top_builddir)/buildutils/pbs_mkdirs
AM_CPPFLAGS = -I$(top_srcdir)/src/include
IFF_PATH = $(sbindir)/$(program_prefix)pbs_iff$(program_suffix)
DEMUX_PATH = $(sbindir)/$(program_prefix)pbs_demux$(program_suffix)
XPBS_DIR = $(libdir)/xpbs
XPBSMON_DIR = $(libdir)/xpbsmon
SUBMIT_FILTER_PATH = $(libexecdir)/qsub_filter
ACLOCAL_AMFLAGS = -I buildutils
SUBDIRS = src doc contrib/blcr contrib/init.d
EXTRA_DIST = acinclude.m4 \
  autogen.sh \
  CHANGELOG \
  configure.ac \
  cov_file_results.py \
	current_hash \
  Doxyfile \
  INSTALL \
	INSTALL.GNU \
  Makefile.am \
  parse_cov_results.py \
  PBS_License.txt \
	README.array_changes \
  README.coding_notes \
	README.configure \
	README.cygwin \
  README.NUMA \
	README.torque \
  README.trqauthd \
	README.building_40 \
	Release_Notes \
  run_report.py \
	torque.setup \
	torque.spec \
	buildutils/config.mk \
	buildutils/modulefiles.in \
	buildutils/modulefiles.vers.in \
	buildutils/pbs_mach_type \
	buildutils/pbs_mkdirs.in \
	buildutils/self-extract-head-sh.in \
	buildutils/torque.spec.in \
	contrib/AddPrivileges \
  contrib/hwloc_install.sh \
  contrib/mom_gencfg \
	contrib/pam_authuser.tar.gz \
	contrib/pbstop \
	contrib/pbsweb-lite-0.95.tar.gz \
	contrib/pestat-1.0/Makefile \
	contrib/pestat-1.0/pestat.c \
	contrib/pestat-1.0/README \
	contrib/qpeek \
	contrib/qpool.gz \
	contrib/PBS_License_2.3.txt \
	contrib/README.pam_authuser \
	contrib/README.pbs_ganglia_jobmonarch \
	contrib/README.pbs_python \
	contrib/README.pbstools \
	contrib/README.pbstop \
	contrib/README.pbs_weblite \
	contrib/README.pestat \
	contrib/README.qpeek \
	contrib/showjobs \
	contrib/diag/tdiag.sh

bin_SCRIPTS = pbs-config
DISTCLEANFILES = pbs-config current_hash
MOSTLYCLEANFILES = *.gcda *.gcno *.gcov
DISTCHECK_CONFIGURE_FLAGS = --with-server-home=$$dc_install_base/spool

#
# Used by the 'packages' target below
#
# Additional package name, should be redefined to something meaningful to
# the user.
PKGNAME = package

# Directory with files that override the packaged files.
# Can be redefined on the make cmdline to a permanent location
PKGOVERRIDE = $(PWD)/pkgoverride

# temp dir for the packaged files and tarballs
PKGROOT = $(PWD)/tpackages
SERVER_PKG = server
MOM_PKG = mom
CLIENTS_PKG = clients
GUI_PKG = gui
#PAM_PKG = pam
#DRMAA_PKG = drmaa
ALL_PKGS = $(SERVER_PKG) $(MOM_PKG) $(CLIENTS_PKG) $(GUI_PKG) $(PAM_PKG) $(DRMAA_PKG) devel doc
#CHECK_DIRS = src
all: all-recursive

.SUFFIXES:
am--refresh:
	@:
$(srcdir)/Makefile.in: # $(srcdir)/Makefile.am $(top_srcdir)/buildutils/config.mk $(am__configure_deps)
	@for dep in $?; do \
	  case '$(am__configure_deps)' in \
	    *$$dep*) \
	      echo ' cd $(srcdir) && $(AUTOMAKE) --foreign'; \
	      $(am__cd) $(srcdir) && $(AUTOMAKE) --foreign \
		&& exit 0; \
	      exit 1;; \
	  esac; \
	done; \
	echo ' cd $(top_srcdir) && $(AUTOMAKE) --foreign Makefile'; \
	$(am__cd) $(top_srcdir) && \
	  $(AUTOMAKE) --foreign Makefile
.PRECIOUS: Makefile
Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	@case '$?' in \
	  *config.status*) \
	    echo ' $(SHELL) ./config.status'; \
	    $(SHELL) ./config.status;; \
	  *) \
	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe)'; \
	    cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe);; \
	esac;

$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
	$(SHELL) ./config.status --recheck

$(top_srcdir)/configure: # $(am__configure_deps)
	$(am__cd) $(srcdir) && $(AUTOCONF)
$(ACLOCAL_M4): # $(am__aclocal_m4_deps)
	$(am__cd) $(srcdir) && $(ACLOCAL) $(ACLOCAL_AMFLAGS)
$(am__aclocal_m4_deps):
torque.spec: $(top_builddir)/config.status $(top_srcdir)/buildutils/torque.spec.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
buildutils/pbs_mkdirs: $(top_builddir)/config.status $(top_srcdir)/buildutils/pbs_mkdirs.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
buildutils/self-extract-head-sh: $(top_builddir)/config.status $(top_srcdir)/buildutils/self-extract-head-sh.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
buildutils/modulefiles: $(top_builddir)/config.status $(top_srcdir)/buildutils/modulefiles.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
buildutils/modulefiles.vers: $(top_builddir)/config.status $(top_srcdir)/buildutils/modulefiles.vers.in
	cd $(top_builddir) && $(SHELL) ./config.status $@
install-binSCRIPTS: $(bin_SCRIPTS)
	@$(NORMAL_INSTALL)
	test -z "$(bindir)" || $(MKDIR_P) "$(DESTDIR)$(bindir)"
	@list='$(bin_SCRIPTS)'; test -n "$(bindir)" || list=; \
	for p in $$list; do \
	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
	  if test -f "$$d$$p"; then echo "$$d$$p"; echo "$$p"; else :; fi; \
	done | \
	sed -e 'p;s,.*/,,;n' \
	    -e 'h;s|.*|.|' \
	    -e 'p;x;s,.*/,,;$(transform)' | sed 'N;N;N;s,\n, ,g' | \
	$(AWK) 'BEGIN { files["."] = ""; dirs["."] = 1; } \
	  { d=$$3; if (dirs[d] != 1) { print "d", d; dirs[d] = 1 } \
	    if ($$2 == $$4) { files[d] = files[d] " " $$1; \
	      if (++n[d] == $(am__install_max)) { \
		print "f", d, files[d]; n[d] = 0; files[d] = "" } } \
	    else { print "f", d "/" $$4, $$1 } } \
	  END { for (d in files) print "f", d, files[d] }' | \
	while read type dir files; do \
	     if test "$$dir" = .; then dir=; else dir=/$$dir; fi; \
	     test -z "$$files" || { \
	       echo " $(INSTALL_SCRIPT) $$files '$(DESTDIR)$(bindir)$$dir'"; \
	       $(INSTALL_SCRIPT) $$files "$(DESTDIR)$(bindir)$$dir" || exit $$?; \
	     } \
	; done

uninstall-binSCRIPTS:
	@$(NORMAL_UNINSTALL)
	@list='$(bin_SCRIPTS)'; test -n "$(bindir)" || exit 0; \
	files=`for p in $$list; do echo "$$p"; done | \
	       sed -e 's,.*/,,;$(transform)'`; \
	test -n "$$list" || exit 0; \
	echo " ( cd '$(DESTDIR)$(bindir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(bindir)" && rm -f $$files

mostlyclean-libtool:
	-rm -f *.lo

clean-libtool:
	-rm -rf .libs _libs

distclean-libtool:
	-rm -f libtool config.lt

# This directory's subdirectories are mostly independent; you can cd
# into them and run `make' without going through this Makefile.
# To change the values of `make' variables: instead of editing Makefiles,
# (1) if the variable is set in `config.status', edit `config.status'
#     (which will cause the Makefiles to be regenerated when you run `make');
# (2) otherwise, pass the desired values on the `make' command line.
$(RECURSIVE_TARGETS):
	@fail= failcom='exit 1'; \
	for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=* | --[!k]*);; \
	    *k*) failcom='fail=yes';; \
	  esac; \
	done; \
	dot_seen=no; \
	target=`echo $@ | sed s/-recursive//`; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  echo "Making $$target in $$subdir"; \
	  if test "$$subdir" = "."; then \
	    dot_seen=yes; \
	    local_target="$$target-am"; \
	  else \
	    local_target="$$target"; \
	  fi; \
	  ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) $$local_target) \
	  || eval $$failcom; \
	done; \
	if test "$$dot_seen" = "no"; then \
	  $(MAKE) $(AM_MAKEFLAGS) "$$target-am" || exit 1; \
	fi; test -z "$$fail"

$(RECURSIVE_CLEAN_TARGETS):
	@fail= failcom='exit 1'; \
	for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=* | --[!k]*);; \
	    *k*) failcom='fail=yes';; \
	  esac; \
	done; \
	dot_seen=no; \
	case "$@" in \
	  distclean-* | maintainer-clean-*) list='$(DIST_SUBDIRS)' ;; \
	  *) list='$(SUBDIRS)' ;; \
	esac; \
	rev=''; for subdir in $$list; do \
	  if test "$$subdir" = "."; then :; else \
	    rev="$$subdir $$rev"; \
	  fi; \
	done; \
	rev="$$rev ."; \
	target=`echo $@ | sed s/-recursive//`; \
	for subdir in $$rev; do \
	  echo "Making $$target in $$subdir"; \
	  if test "$$subdir" = "."; then \
	    local_target="$$target-am"; \
	  else \
	    local_target="$$target"; \
	  fi; \
	  ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) $$local_target) \
	  || eval $$failcom; \
	done && test -z "$$fail"
tags-recursive:
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  test "$$subdir" = . || ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) tags); \
	done
ctags-recursive:
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  test "$$subdir" = . || ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) ctags); \
	done

ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	mkid -fID $$unique
tags: TAGS

TAGS: tags-recursive $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	set x; \
	here=`pwd`; \
	if ($(ETAGS) --etags-include --version) >/dev/null 2>&1; then \
	  include_option=--etags-include; \
	  empty_fix=.; \
	else \
	  include_option=--include; \
	  empty_fix=; \
	fi; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  if test "$$subdir" = .; then :; else \
	    test ! -f $$subdir/TAGS || \
	      set "$$@" "$$include_option=$$here/$$subdir/TAGS"; \
	  fi; \
	done; \
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	shift; \
	if test -z "$(ETAGS_ARGS)$$*$$unique"; then :; else \
	  test -n "$$unique" || unique=$$empty_fix; \
	  if test $$# -gt 0; then \
	    $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	      "$$@" $$unique; \
	  else \
	    $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	      $$unique; \
	  fi; \
	fi
ctags: CTAGS
CTAGS: ctags-recursive $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	test -z "$(CTAGS_ARGS)$$unique" \
	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
	     $$unique

GTAGS:
	here=`$(am__cd) $(top_builddir) && pwd` \
	  && $(am__cd) $(top_srcdir) \
	  && gtags -i $(GTAGS_ARGS) "$$here"

distclean-tags:
	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags

distdir: $(DISTFILES)
	$(am__remove_distdir)
	test -d "$(distdir)" || mkdir "$(distdir)"
	@srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	list='$(DISTFILES)'; \
	  dist_files=`for file in $$list; do echo $$file; done | \
	  sed -e "s|^$$srcdirstrip/||;t" \
	      -e "s|^$$topsrcdirstrip/|$(top_builddir)/|;t"`; \
	case $$dist_files in \
	  */*) $(MKDIR_P) `echo "$$dist_files" | \
			   sed '/\//!d;s|^|$(distdir)/|;s,/[^/]*$$,,' | \
			   sort -u` ;; \
	esac; \
	for file in $$dist_files; do \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  if test -d $$d/$$file; then \
	    dir=`echo "/$$file" | sed -e 's,/[^/]*$$,,'`; \
	    if test -d "$(distdir)/$$file"; then \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -fpR $(srcdir)/$$file "$(distdir)$$dir" || exit 1; \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    cp -fpR $$d/$$file "$(distdir)$$dir" || exit 1; \
	  else \
	    test -f "$(distdir)/$$file" \
	    || cp -p $$d/$$file "$(distdir)/$$file" \
	    || exit 1; \
	  fi; \
	done
	@list='$(DIST_SUBDIRS)'; for subdir in $$list; do \
	  if test "$$subdir" = .; then :; else \
	    test -d "$(distdir)/$$subdir" \
	    || $(MKDIR_P) "$(distdir)/$$subdir" \
	    || exit 1; \
	  fi; \
	done
	@list='$(DIST_SUBDIRS)'; for subdir in $$list; do \
	  if test "$$subdir" = .; then :; else \
	    dir1=$$subdir; dir2="$(distdir)/$$subdir"; \
	    $(am__relativize); \
	    new_distdir=$$reldir; \
	    dir1=$$subdir; dir2="$(top_distdir)"; \
	    $(am__relativize); \
	    new_top_distdir=$$reldir; \
	    echo " (cd $$subdir && $(MAKE) $(AM_MAKEFLAGS) top_distdir="$$new_top_distdir" distdir="$$new_distdir" \\"; \
	    echo "     am__remove_distdir=: am__skip_length_check=: am__skip_mode_fix=: distdir)"; \
	    ($(am__cd) $$subdir && \
	      $(MAKE) $(AM_MAKEFLAGS) \
	        top_distdir="$$new_top_distdir" \
	        distdir="$$new_distdir" \
		am__remove_distdir=: \
		am__skip_length_check=: \
		am__skip_mode_fix=: \
	        distdir) \
	      || exit 1; \
	  fi; \
	done
	$(MAKE) $(AM_MAKEFLAGS) \
	  top_distdir="$(top_distdir)" distdir="$(distdir)" \
	  dist-hook
	-test -n "$(am__skip_mode_fix)" \
	|| find "$(distdir)" -type d ! -perm -755 \
		-exec chmod u+rwx,go+rx {} \; -o \
	  ! -type d ! -perm -444 -links 1 -exec chmod a+r {} \; -o \
	  ! -type d ! -perm -400 -exec chmod a+r {} \; -o \
	  ! -type d ! -perm -444 -exec $(install_sh) -c -m a+r {} {} \; \
	|| chmod -R a+r "$(distdir)"
dist-gzip: distdir
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
	$(am__remove_distdir)

dist-bzip2: distdir
	tardir=$(distdir) && $(am__tar) | bzip2 -9 -c >$(distdir).tar.bz2
	$(am__remove_distdir)

dist-lzma: distdir
	tardir=$(distdir) && $(am__tar) | lzma -9 -c >$(distdir).tar.lzma
	$(am__remove_distdir)

dist-xz: distdir
	tardir=$(distdir) && $(am__tar) | xz -c >$(distdir).tar.xz
	$(am__remove_distdir)

dist-tarZ: distdir
	tardir=$(distdir) && $(am__tar) | compress -c >$(distdir).tar.Z
	$(am__remove_distdir)

dist-shar: distdir
	shar $(distdir) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).shar.gz
	$(am__remove_distdir)

dist-zip: distdir
	-rm -f $(distdir).zip
	zip -rq $(distdir).zip $(distdir)
	$(am__remove_distdir)

dist dist-all: distdir
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
	$(am__remove_distdir)

# This target untars the dist file and tries a VPATH configuration.  Then
# it guarantees that the distribution is self-contained by making another
# tarfile.
distcheck: dist
	case '$(DIST_ARCHIVES)' in \
	*.tar.gz*) \
	  GZIP=$(GZIP_ENV) gzip -dc $(distdir).tar.gz | $(am__untar) ;;\
	*.tar.bz2*) \
	  bzip2 -dc $(distdir).tar.bz2 | $(am__untar) ;;\
	*.tar.lzma*) \
	  lzma -dc $(distdir).tar.lzma | $(am__untar) ;;\
	*.tar.xz*) \
	  xz -dc $(distdir).tar.xz | $(am__untar) ;;\
	*.tar.Z*) \
	  uncompress -c $(distdir).tar.Z | $(am__untar) ;;\
	*.shar.gz*) \
	  GZIP=$(GZIP_ENV) gzip -dc $(distdir).shar.gz | unshar ;;\
	*.zip*) \
	  unzip $(distdir).zip ;;\
	esac
	chmod -R a-w $(distdir); chmod u+w $(distdir)
	mkdir $(distdir)/_build
	mkdir $(distdir)/_inst
	chmod a-w $(distdir)
	test -d $(distdir)/_build || exit 0; \
	dc_install_base=`$(am__cd) $(distdir)/_inst && pwd | sed -e 's,^[^:\\/]:[\\/],/,'` \
	  && dc_destdir="$${TMPDIR-/tmp}/am-dc-$$$$/" \
	  && am__cwd=`pwd` \
	  && $(am__cd) $(distdir)/_build \
	  && ../configure --srcdir=.. --prefix="$$dc_install_base" \
	    $(DISTCHECK_CONFIGURE_FLAGS) \
	  && $(MAKE) $(AM_MAKEFLAGS) \
	  && $(MAKE) $(AM_MAKEFLAGS) dvi \
	  && $(MAKE) $(AM_MAKEFLAGS) check \
	  && $(MAKE) $(AM_MAKEFLAGS) install \
	  && $(MAKE) $(AM_MAKEFLAGS) installcheck \
	  && $(MAKE) $(AM_MAKEFLAGS) uninstall \
	  && $(MAKE) $(AM_MAKEFLAGS) distuninstallcheck_dir="$$dc_install_base" \
	        distuninstallcheck \
	  && chmod -R a-w "$$dc_install_base" \
	  && ({ \
	       (cd ../.. && umask 077 && mkdir "$$dc_destdir") \
	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" install \
	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" uninstall \
	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" \
	            distuninstallcheck_dir="$$dc_destdir" distuninstallcheck; \
	      } || { rm -rf "$$dc_destdir"; exit 1; }) \
	  && rm -rf "$$dc_destdir" \
	  && $(MAKE) $(AM_MAKEFLAGS) dist \
	  && rm -rf $(DIST_ARCHIVES) \
	  && $(MAKE) $(AM_MAKEFLAGS) distcleancheck \
	  && cd "$$am__cwd" \
	  || exit 1
	$(am__remove_distdir)
	@(echo "$(distdir) archives ready for distribution: "; \
	  list='$(DIST_ARCHIVES)'; for i in $$list; do echo $$i; done) | \
	  sed -e 1h -e 1s/./=/g -e 1p -e 1x -e '$$p' -e '$$x'
distuninstallcheck:
	@$(am__cd) '$(distuninstallcheck_dir)' \
	&& test `$(distuninstallcheck_listfiles) | wc -l` -le 1 \
	   || { echo "ERROR: files left after uninstall:" ; \
	        if test -n "$(DESTDIR)"; then \
	          echo "  (check DESTDIR support)"; \
	        fi ; \
	        $(distuninstallcheck_listfiles) ; \
	        exit 1; } >&2
distcleancheck: distclean
	@if test '$(srcdir)' = . ; then \
	  echo "ERROR: distcleancheck can only run from a VPATH build" ; \
	  exit 1 ; \
	fi
	@test `$(distcleancheck_listfiles) | wc -l` -eq 0 \
	  || { echo "ERROR: files left in build directory after distclean:" ; \
	       $(distcleancheck_listfiles) ; \
	       exit 1; } >&2
check-am: all-am
check: check-recursive
all-am: Makefile $(SCRIPTS)
installdirs: installdirs-recursive
installdirs-am:
	for dir in "$(DESTDIR)$(bindir)"; do \
	  test -z "$$dir" || $(MKDIR_P) "$$dir"; \
	done
install: install-recursive
install-exec: install-exec-recursive
install-data: install-data-recursive
uninstall: uninstall-recursive

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-recursive
install-strip:
	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	  `test -z '$(STRIP)' || \
	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
mostlyclean-generic:
	-test -z "$(MOSTLYCLEANFILES)" || rm -f $(MOSTLYCLEANFILES)

clean-generic:

distclean-generic:
	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
	-test . = "$(srcdir)" || test -z "$(CONFIG_CLEAN_VPATH_FILES)" || rm -f $(CONFIG_CLEAN_VPATH_FILES)
	-test -z "$(DISTCLEANFILES)" || rm -f $(DISTCLEANFILES)

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
install-data-hook:
uninstall-hook:
clean: clean-recursive

clean-am: clean-generic clean-libtool mostlyclean-am

distclean: distclean-recursive
	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
	-rm -f Makefile
distclean-am: clean-am distclean-generic distclean-libtool \
	distclean-tags

dvi: dvi-recursive

dvi-am:

html: html-recursive

html-am:

info: info-recursive

info-am:

install-data-am:
	@$(NORMAL_INSTALL)
	$(MAKE) $(AM_MAKEFLAGS) install-data-hook
install-dvi: install-dvi-recursive

install-dvi-am:

install-exec-am: install-binSCRIPTS

install-html: install-html-recursive

install-html-am:

install-info: install-info-recursive

install-info-am:

install-man:

install-pdf: install-pdf-recursive

install-pdf-am:

install-ps: install-ps-recursive

install-ps-am:

installcheck-am:

maintainer-clean: maintainer-clean-recursive
	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
	-rm -rf $(top_srcdir)/autom4te.cache
	-rm -f Makefile
maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-recursive

mostlyclean-am: mostlyclean-generic mostlyclean-libtool

pdf: pdf-recursive

pdf-am:

ps: ps-recursive

ps-am:

uninstall-am: uninstall-binSCRIPTS
	@$(NORMAL_INSTALL)
	$(MAKE) $(AM_MAKEFLAGS) uninstall-hook
.MAKE: $(RECURSIVE_CLEAN_TARGETS) $(RECURSIVE_TARGETS) ctags-recursive \
	install-am install-data-am install-strip tags-recursive \
	uninstall-am

.PHONY: $(RECURSIVE_CLEAN_TARGETS) $(RECURSIVE_TARGETS) CTAGS GTAGS \
	all all-am am--refresh check check-am clean clean-generic \
	clean-libtool ctags ctags-recursive dist dist-all dist-bzip2 \
	dist-gzip dist-hook dist-lzma dist-shar dist-tarZ dist-xz \
	dist-zip distcheck distclean distclean-generic \
	distclean-libtool distclean-tags distcleancheck distdir \
	distuninstallcheck dvi dvi-am html html-am info info-am \
	install install-am install-binSCRIPTS install-data \
	install-data-am install-data-hook install-dvi install-dvi-am \
	install-exec install-exec-am install-html install-html-am \
	install-info install-info-am install-man install-pdf \
	install-pdf-am install-ps install-ps-am install-strip \
	installcheck installcheck-am installdirs installdirs-am \
	maintainer-clean maintainer-clean-generic mostlyclean \
	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
	tags tags-recursive uninstall uninstall-am \
	uninstall-binSCRIPTS uninstall-hook

libtool: $(LIBTOOL_DEPS)
	$(SHELL) ./config.status --recheck

snap:
	$(MAKE) VERSION=$(VERSION)-snap.$${snapstamp:-`date +%Y%m%d%H%M`} dist

dist-hook:
	case $(VERSION) in *-snap.*) \
	    for SPEC in torque.spec buildutils/torque.spec.in ; do \
	        chmod u+w $(distdir)/$$SPEC ; \
	        sed -e 's/^.define snap .*/%define snap 1/;' \
	            -e 's/^.define tarversion .*/%define tarversion $(VERSION)/' \
	            $(srcdir)/$$SPEC > $(distdir)/$$SPEC ; \
	    done ; \
	    chmod u+wx $(distdir)/configure ; \
	    sed -e 's/VERSION=.*/VERSION=$(VERSION)/' $(srcdir)/configure > $(distdir)/configure ;; \
	esac
	chmod u+w $(distdir)/README.torque
	sed -e 's/TORQUE .* README .*/TORQUE $(VERSION) README (released '"`date '+%b, %d %Y'`"')/' $(srcdir)/README.torque > $(distdir)/README.torque

srpm: dist
	rpmbuild -ts $(distdir).tar.gz

rpm: dist
	rpmbuild $(RPM_AC_OPTS) $(RPMOPTS) -tb $(distdir).tar.gz

install_server install_mom install_clients install_gui install_lib install_pam install_drmaa:
	(cd src && $(MAKE) $@)
install_doc:
	(cd doc && $(MAKE) $@)
install_devel: install-binSCRIPTS
	(cd src && $(MAKE) $@)

packages:
	@if `echo $(PKGROOT) | grep ^/ >/dev/null`;then \
          echo "Building packages from $(PKGROOT)"; \
        else \
          echo "Error: PKGROOT must be an absolute path"; \
          exit 1; \
        fi
	rm -rf $(PKGROOT)
	mkdir $(PKGROOT)
	@for d in $(ALL_PKGS);do \
           proot=$(PKGROOT)/$$d; \
           pname=$(PKGNAME); \
           phost=$(PBS_MACH)-x86_64; \
           tarball=$(PKGROOT)/$(PACKAGE_NAME)-$$pname-$$d-$$phost.tar.gz; \
           pkgfile=./$(PACKAGE_NAME)-$$pname-$$d-$$phost.sh; \
           echo "Building $$pkgfile ..."; \
           $(MAKE) DESTDIR=$$proot install_$$d >/dev/null || exit 1; \
	   case $$d in \
	      devel) :;; \
	      *) rm -f $$proot/$(libdir)/*a $$proot/$(libdir)/*.so;; \
	   esac; \
           if test -d $(PKGOVERRIDE)/$$d ;then \
             echo "Using override dir $(PKGOVERRIDE)/$$d"; \
             ( cd $(PKGOVERRIDE)/$$d && tar cf - . | (cd $$proot; tar xvf - ) ); \
           fi; \
           test $$d = gui && echo dummy > $$proot/regen-tclIndex; \
           ( cd $$proot; tar cf - * ) | gzip > $$tarball && \
           ( cd $$proot; tar cf - \
                           `test -f ./post-install && echo ./post-install` \
                           `test -f ./regen-tclIndex && echo ./regen-tclIndex` \
                           `test -d .$(sbindir) && echo .$(sbindir)/*` \
                           `test -d .$(bindir) && echo .$(bindir)/*` \
                           `test -d .$(libdir) && echo .$(libdir)/*` \
                           `test -d .$(mandir) && echo .$(mandir)/*/*` \
                           `test -d .$(includedir) && echo .$(includedir)/*` \
                           `test -d .$(pammoddir) && echo .$(pammoddir)/*` \
                           `test -d .$(PBS_SERVER_HOME) && echo .$(PBS_SERVER_HOME)/*` ) \
                           | gzip > $$tarball && \
           cat ./buildutils/self-extract-head-sh > $$pkgfile && \
           cat $$tarball >> $$pkgfile && \
           chmod 755 $$pkgfile; \
        done
	@echo "Done."
	@echo ""
	@echo "The package files are self-extracting packages that can be copied"; \
        echo "and executed on your production machines.  Use --help for options.";

#install-data-hook:
#	$(INSTALL_DATA) -D ./buildutils/modulefiles $(DESTDIR)$(MODULEFILES_DIR)/$(PACKAGE_NAME)/$(PACKAGE_VERSION)
#	$(INSTALL_DATA) ./buildutils/modulefiles.vers $(DESTDIR)$(MODULEFILES_DIR)/$(PACKAGE_NAME)/.version

#uninstall-hook:
#	rm -f $(DESTDIR)$(MODULEFILES_DIR)/$(PACKAGE_NAME)/$(PACKAGE_VERSION)
#	rm -f $(DESTDIR)$(MODULEFILES_DIR)/$(PACKAGE_NAME)/.version
#	rmdir $(DESTDIR)$(MODULEFILES_DIR)/$(PACKAGE_NAME)
check-recursive:

.PHONY: cleancheck
cleancheck:
	$(MAKE) -C $(CHECK_DIRS) $(MAKECMDGOALS)

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
