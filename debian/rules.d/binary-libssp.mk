arch_binaries  := $(arch_binaries) libssp
ifeq ($(with_lib64ssp),yes)
  arch_binaries  := $(arch_binaries) lib64ssp
endif
ifeq ($(with_lib32ssp),yes)
  arch_binaries	:= $(arch_binaries) lib32ssp
endif
ifeq ($(with_libn32ssp),yes)
  arch_binaries	:= $(arch_binaries) libn32ssp
endif
ifeq ($(with_libx32ssp),yes)
  arch_binaries := $(arch_binaries) libx32ssp
endif

p_ssp	= libssp$(SSP_SONAME)
p_ssp32	= lib32ssp$(SSP_SONAME)
p_ssp64	= lib64ssp$(SSP_SONAME)
p_sspx32 = libx32ssp$(SSP_SONAME)
p_sspd	= libssp$(SSP_SONAME)-dev

d_ssp	= debian/$(p_ssp)
d_ssp32	= debian/$(p_ssp32)
d_ssp64	= debian/$(p_ssp64)
d_sspx32 = debian/$(p_sspx32)
d_sspd	= debian/$(p_sspd)

dirs_ssp = \
	$(docdir)/$(p_base) \
	$(PF)/$(libdir)
files_ssp = \
	$(PF)/$(libdir)/libssp.so.*

dirs_sspd = \
	$(docdir) \
	$(PF)/include \
	$(PF)/$(libdir)
files_sspd = \
	$(gcc_lib_dir)/include/ssp \
	$(PF)/$(libdir)/libssp.{a,so} \
	$(PF)/$(libdir)/libssp_nonshared.a

ifeq ($(with_lib32ssp),yes)
	dirs_sspd  += $(lib32)
	files_sspd += $(lib32)/libssp.{a,so}
	files_sspd += $(lib32)/libssp_nonshared.a
endif
ifeq ($(with_lib64ssp),yes)
	dirs_sspd  += $(PF)/lib64
	files_sspd += $(PF)/lib64/libssp.{a,so}
	files_sspd += $(PF)/lib64/libssp_nonshared.a
endif

$(binary_stamp)-libssp: $(install_stamp)
	dh_testdir
	dh_testroot
	debian/dh_waitforstamp $(install_stamp)
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_ssp)
	dh_installdirs -p$(p_ssp)

	$(dh_compat2) dh_movefiles -p$(p_ssp) $(files_ssp)
	debian/dh_doclink -p$(p_ssp) $(p_lbase)

	debian/dh_rmemptydirs -p$(p_ssp)

	dh_strip -p$(p_ssp)
	dh_makeshlibs $(ldconfig_arg) -p$(p_ssp) -V '$(p_ssp) (>= $(DEB_SOVERSION))'
	dh_shlibdeps -p$(p_ssp)
	echo $(p_ssp) >> debian/arch_binaries

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib64ssp: $(install_stamp)
	dh_testdir
	dh_testroot
	debian/dh_waitforstamp $(install_stamp)
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_ssp64)
	dh_installdirs -p$(p_ssp64) \
		$(PF)/lib64
	$(dh_compat2) dh_movefiles -p$(p_ssp64) \
		$(PF)/lib64/libssp.so.*

	debian/dh_doclink -p$(p_ssp64) $(p_lbase)

	dh_strip -p$(p_ssp64)
	dh_makeshlibs $(ldconfig_arg) -p$(p_ssp64) -V '$(p_ssp64) (>= $(DEB_SOVERSION))'
#	dh_shlibdeps -p$(p_ssp64)
	echo $(p_ssp64) >> debian/arch_binaries

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-lib32ssp: $(install_stamp)
	dh_testdir
	dh_testroot
	debian/dh_waitforstamp $(install_stamp)
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_ssp32)
	dh_installdirs -p$(p_ssp32) \
		$(lib32)
	$(dh_compat2) dh_movefiles -p$(p_ssp32) \
		$(lib32)/libssp.so.*

	debian/dh_doclink -p$(p_ssp32) $(p_lbase)

	dh_strip -p$(p_ssp32)
	dh_makeshlibs $(ldconfig_arg) -p$(p_ssp32) -V '$(p_ssp32) (>= $(DEB_SOVERSION))'
#	dh_shlibdeps -p$(p_ssp32)
	echo $(p_ssp32) >> debian/arch_binaries

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-libn32ssp: $(install_stamp)
	dh_testdir
	dh_testroot
	debian/dh_waitforstamp $(install_stamp)
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_sspn32)
	dh_installdirs -p$(p_sspn32) \
		$(PF)/$(libn32)
	$(dh_compat2) dh_movefiles -p$(p_sspn32) \
		$(PF)/$(libn32)/libssp.so.*

	debian/dh_doclink -p$(p_sspn32) $(p_lbase)

	dh_strip -p$(p_sspn32)
	dh_makeshlibs $(ldconfig_arg) -p$(p_sspn32) -V '$(p_sspn32) (>= $(DEB_SOVERSION))'
#	dh_shlibdeps -p$(p_sspn32)
	echo $(p_sspn32) >> debian/arch_binaries

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)

# ----------------------------------------------------------------------
$(binary_stamp)-libx32ssp: $(install_stamp)
	dh_testdir
	dh_testroot
	debian/dh_waitforstamp $(install_stamp)
	mv $(install_stamp) $(install_stamp)-tmp

	rm -rf $(d_sspx32)
	dh_installdirs -p$(p_sspx32) \
		$(PF)/$(libx32)
	$(dh_compat2) dh_movefiles -p$(p_sspx32) \
		$(PF)/$(libx32)/libssp.so.*

	debian/dh_doclink -p$(p_sspx32) $(p_lbase)

	dh_strip -p$(p_sspx32)
	dh_makeshlibs $(ldconfig_arg) -p$(p_sspx32) -V '$(p_sspx32) (>= $(DEB_SOVERSION))'
#	dh_shlibdeps -p$(p_sspx32)
	echo $(p_sspx32) >> debian/arch_binaries

	trap '' 1 2 3 15; touch $@; mv $(install_stamp)-tmp $(install_stamp)
