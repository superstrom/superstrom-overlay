# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="https://github.com/dvdhrm/kmscon.git"
[[ ${PV} == *9999 ]] && GIT_ECLASS="git-2"

inherit eutils flag-o-matic autotools ${GIT_ECLASS}

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="https://github.com/dvdhrm/kmscon/wiki/KMSCON"

DESCRIPTION="Kmscon is a simple terminal emulator based on linux kernel mode setting (KMS)"
KEYWORDS="**"
IUSE="+debug fbdev freetype +gles pango +xkbcommon"
[[ ${PV} == *9999 ]] || SRC_URI="https://github.com/dvdhrm/kmscon/tarball/${P} -> ${P}.tar.gz"
SLOT="0"
LICENSE="MIT"

RDEPEND="
	x11-libs/libxkbcommon
	pango? ( x11-libs/pango )
	freetype? ( media-libs/freetype:2 )
	gles? ( media-libs/mesa[gles2] )
	xkbcommon? ( x11-libs/libxkbcommon )
"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.6"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable pango) \
		$(use_enable freetype freetype2) \
		$(use_enable gles gles2) \
		$(use_enable fbdev) \
		$(use_enable xkbcommon) \

}
