# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils 
#subversion

DESCRIPTION="logs OBDII and GPS data on Linux, OSX and others."
HOMEPAGE="http://icculus.org/obdgpslogger/"
SRC_URI="http://icculus.org/obdgpslogger/downloads/${P}.tar.gz"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gui"

RDEPEND="
	sys-apps/dbus
	sci-geosciences/gpsd
        gui? x11-libs/fltk"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/subversion"

#ESVN_REPO_URI="svn://svn.icculus.org/obdgpslogger/trunk"

# CMAKE_INSTALL_PREFIX=${D}

#src_install () {
#	emake DESTDIR="${D}" install || die "Install failed"
#	dodoc AUTHORS ChangeLog README || die "dodoc failed"
#}
