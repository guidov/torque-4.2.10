include $(top_srcdir)/buildutils/config.mk

CHECK_DIR = test

DIST_SUBDIRS =
CLEANFILES = *.gcda *.gcno *.gcov

PBS_LIBS = ../lib/Libpbs/libtorque.la

sbin_PROGRAMS = momctl

LDADD = $(PBS_LIBS)

momctl_SOURCES = momctl.c

install-exec-hook:
	$(PBS_MKDIRS) aux || :
	$(PBS_MKDIRS) default

uninstall-hook:
	rm -f $(DESTDIR)$(PBS_DEFAULT_FILE)

if HAVE_CHECK
check:
	$(MAKE) -C $(CHECK_DIR) $(MAKECMDGOALS)

.PHONY: cleancheck
cleancheck:
	cd test && $(MAKE) cleancheck
endif
