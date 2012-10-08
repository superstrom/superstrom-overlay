# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="https://github.com/otcshare/automotive-message-broker.git"
inherit cmake-utils git-2

DESCRIPTION="A framework for accessing vehicle information"
HOMEPAGE="https://wiki.tizen.org/wiki/Automotive_Message_Broker"
SRC_URI=""

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/boost
	>=dev-libs/glib-2
	net-libs/libwebsockets
"

DEPEND="${RDEPEND}"
