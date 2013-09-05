# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/garmintools/garmintools-0.10.ebuild $

EAPI="5"

inherit autotools eutils

DESCRIPTION="Simple tool to communicate with Garmin Forerunner GPS watches"
HOMEPAGE="http://code.google.com/p/garmintools/"
SRC_URI="http://garmintools.googlecode.com/files/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/libusb:0"
DEPEND="${RDEPEND}"
