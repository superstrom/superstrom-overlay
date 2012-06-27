# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.10.2-r2.ebuild,v 1.1 2012/01/29 15:53:24 wired Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/git/cairo"
[[ ${PV} == *9999 ]] && GIT_ECLASS="git-2"

inherit eutils flag-o-matic autotools ${GIT_ECLASS}

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
[[ ${PV} == *9999 ]] || SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="X aqua debug directfb doc drm gallium +glib opengl openvg qt4 static-libs +svg xcb"
IUSE="${IUSE} cairo-perf-trace"

# Test causes a circular depend on gtk+... since gtk+ needs cairo but test needs gtk+ so we need to block it
RESTRICT="test"

RDEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libpng:0
	sys-libs/zlib
	>=x11-libs/pixman-0.18.4
	directfb? ( dev-libs/DirectFB )
	glib? ( dev-libs/glib:2 )
	opengl? ( virtual/opengl )
	openvg? ( media-libs/mesa[gallium] )
	qt4? ( >=x11-libs/qt-gui-4.4:4 )
	svg? ( dev-libs/libxml2 )
	X? (
		>=x11-libs/libXrender-0.6
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXft
		drm? (
			>=sys-fs/udev-136
			gallium? ( media-libs/mesa[gallium] )
		)
	)
	xcb? (
		x11-libs/libxcb
		x11-libs/xcb-util
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/libtool-2
	doc? (
		>=dev-util/gtk-doc-1.6
		~app-text/docbook-xml-dtd-4.2
	)
	X? (
		x11-proto/renderproto
		drm? (
			x11-proto/xproto
			>=x11-proto/xextproto-7.1
		)
	)"

# drm module requires X
# for gallium we need to enable drm
REQUIRED_USE="
	drm? ( X )
	gallium? ( drm )
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-interix.patch
	epatch "${FILESDIR}"/${P}-qt-surface.patch

	# Slightly messed build system YAY
	if [[ ${PV} == *9999* ]]; then
		touch boilerplate/Makefile.am.features
		touch src/Makefile.am.features
		touch ChangeLog
	fi

	# We need to run elibtoolize to ensure correct so versioning on FreeBSD
	# upgraded to an eautoreconf for the above interix patch.
	eautoreconf
}

src_configure() {
	local myopts

	# SuperH doesn't have native atomics yet
	use sh && myopts+=" --disable-atomic"

	[[ ${CHOST} == *-interix* ]] && append-flags -D_REENTRANT

	# tracing fails to compile, because Solaris' libelf doesn't do large files
	[[ ${CHOST} == *-solaris* ]] && myopts+=" --disable-trace"

	# 128-bits long arithemetic functions are missing
	[[ ${CHOST} == powerpc*-*-darwin* ]] && filter-flags -mcpu=*

	#gets rid of fbmmx.c inlining warnings
	append-flags -finline-limit=1200
	# --disable-xcb-lib:
	#	do not override good xlib backed by hardforcing rendering over xcb
	econf \
		--disable-dependency-tracking \
		$(use_with X x) \
		$(use_enable X xlib) \
		$(use_enable X xlib-xrender) \
		$(use_enable X tee) \
		$(use_enable aqua quartz) \
		$(use_enable aqua quartz-image) \
		$(use_enable debug test-surfaces) \
		$(use_enable directfb) \
		$(use_enable glib gobject) \
		$(use_enable doc gtk-doc) \
		$(use_enable openvg vg) \
		$(use_enable opengl gl) \
		$(use_enable qt4 qt) \
		$(use_enable static-libs static) \
		$(use_enable svg) \
		$(use_enable xcb) \
		$(use_enable xcb xcb-shm) \
		$(use_enable drm) \
		$(use_enable gallium) \
		--enable-ft \
		--enable-pdf \
		--enable-png \
		--enable-ps \
		--disable-xlib-xcb \
		${myopts}
}

src_compile() {
	emake || die "Build failed"

	if use cairo-perf-trace; then
		emake -C "${S}/perf" cairo-perf-trace || \
		    die "cairo-perf-trace build failed"
	fi
}

src_install() {
	# parallel make install fails
	emake -j1 DESTDIR="${D}" install
	find "${ED}" -name '*.la' -exec rm -f {} +
	dodoc AUTHORS ChangeLog NEWS README

	if use cairo-perf-trace; then
		dobin "${S}/perf/.libs/cairo-perf-trace" || die
	fi
}
