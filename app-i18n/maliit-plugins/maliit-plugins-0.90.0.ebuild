# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils multilib qt4-r2
IUSE=""

DESCRIPTION="Maliit provides a flexible and cross-platform input method framework"
HOMEPAGE="http://maliit.org"
#EGIT_REPO_URI="git://gitorious.org/maliit/${PN}"
SRC_URI="http://maliit.org/releases/${PN}/${P}.tar.bz2"

# Minimal supported version of Qt.
QT_VER="4.7.4"

RDEPEND="
	=app-i18n/maliit-framework-${PV}
	>=x11-libs/qt-core-${QT_VER}:4
	>=x11-libs/qt-gui-${QT_VER}:4
	>=x11-libs/qt-dbus-${QT_VER}:4
	>=x11-libs/qt-declarative-${QT_VER}:4
	>=x11-libs/qt-script-${QT_VER}:4
	>=x11-libs/qt-test-${QT_VER}:4
	>=x11-libs/qt-xmlpatterns-${QT_VER}:4
"

DEPEND="
	${RDEPEND}"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64"

src_configure() {
	eqmake4 -r
}
