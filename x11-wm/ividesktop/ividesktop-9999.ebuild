# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit qt4-r2 git multilib toolchain-funcs gnome2-utils

DESCRIPTION="ividesktop is the desktop application for the ivihome environment."
HOMEPAGE="http://meego.com"
EGIT_REPO_URI="git://gitorious.org/meego-ivi-ux/ividesktop.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug pch plainqt"

COMMON_DEPEND="
	x11-libs/libXfixes
	x11-libs/libXdamage
	>=x11-libs/qt-gui-4.6.0:4
	>=x11-libs/qt-svg-4.6.0:4
	>=x11-libs/qt-opengl-4.6.0:4
	"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"
#RDEPEND="${COMMON_DEPEND}
#	~x11-themes/meegotouch-theme-${PV}"

DOCS="README"

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
