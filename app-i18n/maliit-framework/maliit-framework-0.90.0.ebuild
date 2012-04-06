# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils multilib qt4-r2
IUSE=""

DESCRIPTION="Maliit provides a flexible and cross-platform input method framework"
HOMEPAGE="http://maliit.org"
#EGIT_SRC_URI="git://gitorious.org/maliit/${PN}.git"
SRC_URI="http://maliit.org/releases/${PN}/${P}.tar.bz2"

# Minimal supported version of Qt.
QT_VER="4.7.4"

RDEPEND="
	>=x11-libs/qt-core-${QT_VER}:4
	>=x11-libs/qt-gui-${QT_VER}:4
	>=x11-libs/qt-dbus-${QT_VER}:4
	>=x11-libs/qt-declarative-${QT_VER}:4
	>=x11-libs/qt-script-${QT_VER}:4
	>=x11-libs/qt-sql-${QT_VER}:4
	>=x11-libs/qt-test-${QT_VER}:4
	>=x11-libs/qt-xmlpatterns-${QT_VER}:4
"

DEPEND="
	${RDEPEND}"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64"

src_prepare() {
	epatch ${FILESDIR}/maliit-framework-0.80.6-launchopt.patch
	epatch ${FILESDIR}/maliit-framework-0.80.6-remove-gconf-register.patch
}

src_configure() {
	eqmake4 \
	-r \
	M_IM_PREFIX=/usr \
	M_IM_INSTALL_SCHEMAS=/usr/share/GConf/schema
}

src_install() {
	emake INSTALL_ROOT=${D} install || die "install failed"
}

pkg_postinst() {
	elog "Install GConf Schema..."
	GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source` gconftool-2 \
	--makefile-install-rule /usr/share/GConf/schema/maliit-framework.schemas
}

pkg_prerm() {
	elog "Uninstall GConf Schema..."
	GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source` gconftool-2 \
	--makefile-uninstall-rule /usr/share/GConf/schema/maliit-framework.schemas
}
