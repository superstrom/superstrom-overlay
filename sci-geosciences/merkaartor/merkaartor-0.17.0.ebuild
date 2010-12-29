# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/merkaartor/merkaartor-0.13.2.ebuild,v 1.1 2009/05/04 21:44:56 hanno Exp $

EAPI="3"

inherit eutils qt4 versionator

DESCRIPTION="A Qt4 based map editor for the openstreetmap.org project"
HOMEPAGE="http://www.merkaartor.be"
SRC_URI="http://www.merkaartor.be/attachments/download/192/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls webkit exif gdal boost proj"
DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	boost? ( dev-libs/boost )
	exif? ( media-gfx/exiv2 )
	webkit? ( >=x11-libs/qt-webkit-4.3.3 )
	proj? ( sci-libs/proj )
	gdal? ( sci-libs/gdal )"
RDEPEND="${DEPEND}"


src_prepare() {
	epatch "${FILESDIR}/MainWindow-0.16.3.patch"
}

src_configure() {
	local myconf

	use boost && myconf="${myconf} USE_BUILTIN_BOOST=0" || myconf="${myconf} USE_BUILTIN_BOOST=1"

	use webkit || myconf="${myconf} NOUSEWEBKIT=1"
	use exif && myconf="${myconf} GEOIMAGE=1" || myconf="${myconf} GEOIMAGE=0"
	use proj && myconf="${myconf} PROJ=1" || myconf="${myconf} PROJ=0"
	use gdal && myconf="${myconf} GDAL=1" || myconf="${myconf} GDAL=0"

	if use nls; then
		lrelease Merkaartor.pro || die "lrelease failed"
	fi

	eqmake4 Merkaartor.pro PREFIX=/usr ${myconf} || die "eqmake4 failed"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dodoc AUTHORS CHANGELOG HACKING || die "dodoc failed"

	newicon Icons/Merkaartor_100x100.png "${PN}".png || die "newicon failed"
	make_desktop_entry "${PN}" "Merkaartor" "${PN}" "Science;Geoscience"
}
