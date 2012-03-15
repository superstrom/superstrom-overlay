# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpxviewer/gpxviewer-0.2.0.ebuild,v 1.6 2012/02/14 21:36:14 ulm Exp $

EAPI="2"

inherit autotools eutils

MY_PN="gpx-viewer"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple program to visualize a gpx file"
HOMEPAGE="http://blog.sarine.nl/${PN}/"
SRC_URI="http://bazaar.launchpad.net/~gpx-viewer-team/gpx-viewer/port-to-libchamplain-0.12/tarball/222 -> ${MY_PN}-bzr-222.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	dev-lang/vala
	dev-libs/gdl:3
	dev-libs/glib:2
	dev-libs/libunique:1
	dev-libs/libxml2:2
	media-libs/clutter
	media-libs/libchamplain:0.12[gtk]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

S="${WORKDIR}/~gpx-viewer-team/gpx-viewer/port-to-libchamplain-0.12"

src_prepare() {
	epatch "${FILESDIR}/${PV}-configure.ac.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls)
}

src_compile() {
	emake gpx_viewer_vala.stamp || die
	emake || die
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dosym ../icons/hicolor/scalable/apps/gpx-viewer.svg /usr/share/pixmaps/gpx-viewer.svg || die
	dodoc AUTHORS README ChangeLog || die "dodoc failed"
}
