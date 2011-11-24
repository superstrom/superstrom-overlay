# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
#inherit eutils git multilib qt4-r2
inherit eutils multilib qt4-r2
#IUSE="+X +gtk +qt4 +anthy +socialime +linguas_ja sdk examples tests"
#IUSE="+X +gtk +qt4 +anthy +socialime +googleime declarative sdk tests examples"
IUSE=""

DESCRIPTION="Maliit provides a flexible and cross-platform input method framework"
HOMEPAGE="http://maliit.org"
#EGIT_REPO_URI="git://gitorious.org/qimsys/qimsys.git"
#Now use my git repository
#EGIT_REPO_URI="git://gitorious.org/~kenya888/qimsys/kenya888s-qimsys.git"
SRC_URI="http://gitorious.org/maliit/maliit-framework/archive-tarball/${PV} -> ${P}.tar.gz"

# Minimal supported version of Qt.
QT_VER="4.7.4"

RDEPEND="
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

#pkg_setup() {
#}

#src_unpack() {
#	git_src_unpack
#}

src_prepare() {
	epatch ${FILESDIR}/maliit-framework-0.80.6-launchopt.patch
	epatch ${FILESDIR}/maliit-framework-0.80.6-remove-gconf-register.patch
}

src_configure() {
	# use qmake to configure
	#conflist=""
	#use tests && conflist="${conflist} QIMSYS_CONFIG+=tests"

	S=${S}/maliit-maliit-framework
	cd "${S}"

	#eqmake4 ${S}/maliit-maliit-framework/${PN}.pro \
	eqmake4 \
	-r \
	M_IM_PREFIX=/usr \
	M_IM_INSTALL_SCHEMAS=/usr/share/GConf/schema

	#${conflist}
}

src_compile() {
	emake || die "make failed"
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
