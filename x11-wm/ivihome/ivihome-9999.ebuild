# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit qt4-r2 git multilib toolchain-funcs

DESCRIPTION="ivihome is the primary application for the IVI desktop. It loads the task bar which supplies the window selection list and the application launch window which pulls in all the .desktop files for installed apps. This program lists, launches, closes, and selects applications."
HOMEPAGE="http://meego.com"
EGIT_REPO_URI="git://gitorious.org/meego-ivi-ux/ivihome.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
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
	dev-util/pkgconfig"

DOCS="README"

src_configure() {
	sed -e "/^DEFINES +=/d" -i ivihome.pro
	#add back in? with use?

	eqmake4 "${S}"/ivihome.pro
}
