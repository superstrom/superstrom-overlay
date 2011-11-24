# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
#inherit eutils git multilib qt4-r2
inherit eutils multilib qt4-r2
IUSE=""

DESCRIPTION="Maliit provides a flexible and cross-platform input method framework"
HOMEPAGE="http://maliit.org"
#EGIT_REPO_URI="git://gitorious.org/qimsys/qimsys.git"
#Now use my git repository
#EGIT_REPO_URI="git://gitorious.org/~kenya888/qimsys/kenya888s-qimsys.git"
SRC_URI="http://gitorious.org/maliit/maliit-plugins/archive-tarball/${PV} -> ${P}.tar.gz"

# Minimal supported version of Qt.
QT_VER="4.7.4"

RDEPEND="
	=app-i18n/maliit-framework-${PV}
	>=x11-libs/qt-core-${QT_VER}:4
	>=x11-libs/qt-gui-${QT_VER}:4
	>=x11-libs/qt-dbus-${QT_VER}:4
	>=x11-libs/qt-declarative-${QT_VER}:4
	>=x11-libs/qt-script-${QT_VER}:4
	>=x11-libs/qt-sql-${QT_VER}:4
	>=x11-libs/qt-xmlpatterns-${QT_VER}:4
"

DEPEND="
	${RDEPEND}"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64"

src_configure() {
	# use qmake to configure
	#conflist=""
	#use tests && conflist="${conflist} QIMSYS_CONFIG+=tests"

	S=${S}/maliit-maliit-plugins
	cd "${S}"

	#eqmake4 ${S}/maliit-maliit-framework/${PN}.pro \
	eqmake4 \
	-r

	#${conflist}
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT=${D} install || die "install failed"
}
