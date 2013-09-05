
EAPI="5"
inherit eutils qt4-r2

IUSE=""

DESCRIPTION="MoNav offers state-of-the-art fast and exact routing with OpenStreetMap Data"
HOMEPAGE="https://code.google.com/p/monav/"
SRC_URI="http://monav.googlecode.com/files/${P}.tar.gz"

RDEPEND="
	dev-libs/libxml2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qt-mobility[location]
"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"

S=${WORKDIR}/${P}

src_configure() {
	eqmake4 "${S}/monavclient.pro"
}
