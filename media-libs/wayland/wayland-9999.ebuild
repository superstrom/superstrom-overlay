# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://anongit.freedesktop.org/wayland"
#EGIT_BOOTSTRAP="eautoreconf"

inherit autotools autotools-utils git

DESCRIPTION="Wayland is a nano display server"
HOMEPAGE="http://wayland.freedesktop.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demo"

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
	"${FILESDIR}/${P}-install_compositor.patch"
)

src_prepare() {
	git_src_prepare

	cd ${S}
	if use demo; then
		epatch "${FILESDIR}/${P}-install_demo.patch"
	fi

	eautoreconf
}

src_configure() {
	econf	--program-prefix=wayland-
}

src_install() {
	autotools-utils_src_install

        insinto /etc/udev/rules.d/
        newins "${S}/compositor/70-wayland.rules" 70-wayland.rules || die
}

pkg_postinst() {
        udevadm control --reload-rules && udevadm trigger --subsystem-match=drm --subsystem-match=input
}
