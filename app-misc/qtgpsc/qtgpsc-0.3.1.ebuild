# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils

DESCRIPTION="qtGPSc is a simple graphical client for gpsd"
HOMEPAGE="http://code.google.com/p/qtgpsc/"
SRC_URI="http://qtgpsc.googlecode.com/files/${P}.tar.gz"
#ESVN_REPO_URI="https://qtgpsc.googlecode.com/hg/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/qt-core
	sci-geosciences/gpsd"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( dev-util/subversion dev-vcs/subversion )"
