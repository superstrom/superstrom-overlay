# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

REAL_PN="libwebsockets-1.22-chrome26-firefox18"

inherit autotools

DESCRIPTION="C Websockets Server Library"
HOMEPAGE="http://libwebsockets.org"
SRC_URI="http://git.warmcat.com/cgi-bin/cgit/libwebsockets/snapshot/${REAL_PN}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openssl +libcrypto nofork noping"
DEPEND="openssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${REAL_PN}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
	  $(use_enable openssl) \
	  $(use_enable libcrypto) \
	  $(use_enable nofork) \
	  $(use_enable noping)
}

src_install() {
	emake install DESTDIR="${D}" || die
}
