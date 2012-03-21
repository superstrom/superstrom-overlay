EAPI="4"

inherit autotools eutils

DESCRIPTION="Simple tool to communicate with Garmin Forerunner GPS watches"
HOMEPAGE="http://code.google.com/p/garmintools/"
SRC_URI="http://garmintools.googlecode.com/files/${PN}-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libusb"
DEPEND="${RDEPEND}"
