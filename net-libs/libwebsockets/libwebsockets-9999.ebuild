# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://git.warmcat.com/libwebsockets"

inherit git-2 autotools

DESCRIPTION="C Websockets Server Library"
HOMEPAGE="http://libwebsockets.org"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="openssl +libcrypto nofork noping"
DEPEND="openssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

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
