
EAPI="4"
inherit eutils qt4-r2

IUSE=""

DESCRIPTION="MoNav is a Desktop / Mobile application that offers state-of-the-art fast and exact routing with OpenStreetMap Data."
HOMEPAGE="https://code.google.com/p/monav/"
SRC_URI="http://monav.googlecode.com/files/${P}.tar.gz"

RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-mobility[location]
"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"

S=${WORKDIR}/${P}

src_configure() {
	eqmake4 "${S}/monavclient.pro"
}
