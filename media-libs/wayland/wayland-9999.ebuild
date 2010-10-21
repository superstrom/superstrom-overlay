# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://anongit.freedesktop.org/~krh/wayland"
EGIT_BOOTSTRAP="eautoreconf"

inherit autotools autotools-utils git

DESCRIPTION="Wayland is a nano display server"
HOMEPAGE="http://groups.google.com/group/wayland-display-server"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/cairo[opengl]
	x11-libs/libxkbcommon
	x11-libs/libdrm[libkms]
	media-libs/mesa[gles]
	media-libs/libpng
	x11-libs/gtk+
	>=sys-fs/udev-136
	x11-libs/libxcb
	dev-libs/glib:2
	app-text/poppler
	dev-libs/libffi"

RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

EGIT_PATCHES=(
	"${FILESDIR}/${P}-as_needed.patch"
)