
EAPI="4"
inherit cmake-utils git-2

DESCRIPTION="An open source Linux client for Google Drive."
HOMEPAGE="http://match065.github.com/grive/"
EGIT_REPO_URI="https://github.com/match065/grive.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	net-misc/curl
	dev-libs/json-c
	dev-libs/openssl
	dev-libs/expat"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"
