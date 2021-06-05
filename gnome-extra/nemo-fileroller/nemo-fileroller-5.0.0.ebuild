# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit meson

DESCRIPTION="File Roller integration for Nemo"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${PV}.tar.gz"
S="${WORKDIR}/nemo-extensions-${PV}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="app-arch/file-roller
	>=gnome-extra/nemo-${PV}"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use doc)
	)
	meson_src_configure
}
