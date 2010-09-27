# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils subversion

DESCRIPTION="logs OBDII and GPS data on Linux, OSX and others."
HOMEPAGE="http://icculus.org/obdgpslogger/"
#SRC_URI="http://icculus.org/obdgpslogger/downloads/${P}.tar.gz"
SRC_URI=""
ESVN_REPO_URI="svn://svn.icculus.org/obdgpslogger/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus ftdi gpsd gui"

RDEPEND="
	dbus? ( sys-apps/dbus )
	gpsd? ( sci-geosciences/gpsd )
	ftdi? ( dev-embedded/libftdi )
        gui? ( x11-libs/fltk )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( dev-util/subversion  dev-vcs/subversion )"


src_configure() {
        mycmakeargs=(
		$(cmake-utils_use_enable gui OBD_ENABLE_GUI)
		$(cmake-utils_use_enable dbus OBD_ENABLE_DBUS)
		$(cmake-utils_use_enable gpsd OBD_ENABLE_GPSD)
        )
        cmake-utils_src_configure
}
