# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit qt4-r2 rpm multilib toolchain-funcs gnome2-utils versionator

MEEGO_V=1.1.80
MEEGO_VV=${MEEGO_V}.4.20101102.1

MY_PV=$(replace_version_separator 2 '-')
MY_P=${PN}-${MY_PV}

DESCRIPTION="ividesktop is the desktop application for the ivihome environment."
HOMEPAGE="http://meego.com"
EGIT_REPO_URI="git://gitorious.org/meego-ivi-ux/ividesktop.git"
SRC_URI="http://repo.meego.com/MeeGo/builds/${MEEGO_V}/${MEEGO_VV}/ivi/repos/source/${MY_P}.src.rpm"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug pch plainqt"

COMMON_DEPEND="
	x11-libs/libXfixes
	x11-libs/libXdamage
	>=x11-libs/qt-gui-4.6.0:4
	>=x11-libs/qt-svg-4.6.0:4
	>=x11-libs/qt-opengl-4.6.0:4
	"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	app-arch/rpm2targz"
#RDEPEND="${COMMON_DEPEND}
#	~x11-themes/meegotouch-theme-${PV}"

DOCS="README"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_unpack() {
	rpm_src_unpack ${A}
}

use_make() {
	local arg=${2:-$1}

	if use $1; then
		echo "-make ${arg}"
	else
		echo "-nomake ${arg}"
	fi
}

src_prepare() {
	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 M_BUILD_TREE="${S}" M_SOURCE_TREE="${S}"
}
