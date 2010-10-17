# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools eutils flag-o-matic linux-info mono multilib nsplugins pax-utils

DESCRIPTION="Moonlight is an open source implementation of Silverlight"
HOMEPAGE="http://www.go-mono.com/moonlight/"

MIRRORMOON="ftp://ftp.novell.com/pub/mono/sources/moon/${PV}/"
MONO="mono-2.7"
MONOBASIC="mono-basic-2.7"
SRC_URI="${MIRRORMOON}/${P}.tar.bz2
	${MIRRORMOON}/${MONO}.tar.bz2
	${MIRRORMOON}/${MONOBASIC}.tar.bz2"
LICENSE="BSD-4 GPL-2 GPL-2-with-linking-exception IDPL LGPL-2 MIT Ms-PL NPL-1.1"
SLOT="0"
KEYWORDS="**"
IUSE="alsa curl debug hardened +nsplugin pulseaudio sdk test"
RESTRICT="mirror"

RDEPEND="
	curl? ( net-misc/curl )
	>=x11-libs/gtk+-2.14
	>=dev-libs/glib-2.18
	>=x11-libs/cairo-1.8.4
	>=media-video/ffmpeg-0.4.9_p20090121
	>=net-libs/xulrunner-1.9.1:1.9
	x11-libs/libXrandr
	alsa? ( >=media-libs/alsa-lib-1.0.18 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.14 )
	>=media-libs/freetype-2.3.7
	>=media-libs/fontconfig-2.6.0
	>=dev-lang/mono-2.7[moonlight]
	>=dev-dotnet/gtk-sharp-2.12.9
	dev-dotnet/wnck-sharp
	dev-dotnet/rsvg-sharp"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23
	dev-libs/expat"

pkg_setup() {
	if use kernel_linux; then
		get_version
		if linux_config_exists; then
			if linux_chkconfig_present SYSVIPC; then
				einfo "CONFIG_SYSVIPC is set, looking good."
			else
				eerror "If CONFIG_SYSVIPC is not set in your kernel .config, mono compilation will hang."
				eerror "See http://bugs.gentoo.org/261869 for more info."
				die "Please set CONFIG_SYSVIPC in your kernel .config"
			fi
		else
			ewarn "Was unable to determine your kernel .config"
			ewarn "Please note that if CONFIG_SYSVIPC is not set in your kernel .config, mono compilation will hang."
			ewarn "See http://bugs.gentoo.org/261869 for more info."
		fi
	fi
}

src_prepare() {
	# we need to sed in the paxctl -m in the runtime/mono-wrapper.in so it don't
	# get killed in the build proces when MPROTEC is enable. #286280
	if use hardened ; then
		ewarn "We are disabling MPROTECT on the mono binary."
		sed '/exec/ i\paxctl -m "$r/@mono_runtime@"' -i "${S}"/runtime/mono-wrapper.in
	fi

	mkdir ${S}/perf
	#cp "${FILESDIR}/perf_Makefile.in" perf/Makefile.in
	touch ${S}/perf/Makefile.in

	#sed -i \
	#	-e "s:TEST_SUBDIR = test::"	\
	#	-e "s:TOOLS_SUBDIR = tools::"	\
	#	 Makefile.in

	# the configure script has these hard coded
	ln -s ${MONO}/mcs ${WORKDIR}/mcs
	ln -s ${MONOBASIC} ${WORKDIR}/mono-basic
}

src_configure() {
	# Moonlight requires a full configure/make in the mono folder
	einfo "Running configure in "${WORKDIR}/${MONO}""
	cd "${WORKDIR}/${MONO}"
	# mono's build system is finiky, strip the flags
	strip-flags
	econf	--disable-dependency-tracking \
		--with-moonlight=yes \
		|| die "econf mono failed"

	einfo "Running configure in "${S}""
	cd "${S}"
	econf	--enable-shared \
		--disable-static \
		--with-manual-mono=yes \
	 	--with-cairo=system \
		--with-ffmpeg=yes \
		--with-ff3=yes \
		--without-ff2 \
		--enable-desktop-support \
		--with-curl=$(use !curl && printf "no" || printf "system" ) \
		--with-gallium-path=/usr/include/GL/ \
		$(use_enable nsplugin browser-support) \
		$(use_enable sdk) \
		$(use_with alsa) \
		$(use_with pulseaudio) \
		$(use_with debug) \
		$(use_with test testing) \
		$(use_with test performance) \
		--without-examples \
		|| die "econf moonlight failed"

		#--with-mcspath="${WORKDIR}/${MONO}/mcs" \
		#--with-mono-basic-path="${WORKDIR}/${MONOBASIC}" \
}

src_compile() {
	einfo "Running make in "${WORKDIR}/${MONO}""
	cd "${WORKDIR}/${MONO}"
	# mono does not like parallel build, bug #249985
	emake -j1 || die "emake mono failed"

	einfo "Running make in "${S}""
	cd "${S}"
	# and moonlight neither, bug #337960, upstream bug #640395
	emake -j1 || die "emake moonlight failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use nsplugin; then
		inst_plugin /usr/$(get_libdir)/moonlight/plugin/libmoonloader.so || die "installing libmoonloader failed"
	fi
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
