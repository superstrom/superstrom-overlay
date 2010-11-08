# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit qt4-r2 rpm multilib toolchain-funcs versionator

MEEGO_V=1.1.80
MEEGO_VV=${MEEGO_V}.4.20101102.1

MY_PV=$(replace_version_separator 2 '-')
MY_P=${PN}-${MY_PV}

DESCRIPTION="ivihome is the primary application for the IVI desktop. It loads the task bar which supplies the window selection list and the application launch window which pulls in all the .desktop files for installed apps. This program lists, launches, closes, and selects applications."
HOMEPAGE="http://meego.com"
EGIT_REPO_URI="git://gitorious.org/meego-ivi-ux/ivihome.git"
SRC_URI="http://repo.meego.com/MeeGo/builds/${MEEGO_V}/${MEEGO_VV}/ivi/repos/source/${MY_P}.src.rpm"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug pch plainqt tts voice"

COMMON_DEPEND="
	x11-libs/libmatchbox
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/libXcomposite
	tts? app-accessibility/festival
	"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	app-arch/rpm2targz"

DOCS="README"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_unpack() {
	rpm_src_unpack ${A}
}

src_configure() {
	sed -e "/^DEFINES +=/d" -i ivihome.pro
	#add back in? with use?

	eqmake4 "${S}"/ivihome.pro
}
