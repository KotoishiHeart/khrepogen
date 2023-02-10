# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C99 library implementation of AWS client-side authentication: standard credentials providers and signing."
HOMEPAGE="https://github.com/awslabs/aws-c-auth"
SRC_URI="https://github.com/awslabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/aws-c-common:0=[static-libs=]
	dev-libs/aws-c-cal:0=[static-libs=]
	dev-libs/aws-c-io:0=[static-libs=]
	dev-libs/aws-c-compression:0=[static-libs=]
	dev-libs/aws-c-http:0=[static-libs=]
	dev-libs/aws-c-sdkutils:0=[static-libs=]
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.6.11-cmake-prefix.patch
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
