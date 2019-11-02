# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://simplenote.com https://github.com/Automattic/simplenote-electron"
SRC_URI="https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/Simplenote-linux-${PV}-x64.tar.gz"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-crypt/libsecret:0
        dev-libs/atk:0
        dev-libs/expat:0
        dev-libs/glib:2
        dev-libs/nspr:0
        dev-libs/nss:0
        gnome-base/gconf:2
        media-libs/alsa-lib:0
        media-libs/fontconfig:1.0
        media-libs/freetype:2
        net-misc/curl:0
        sys-apps/dbus:0
        x11-libs/cairo:0
        x11-libs/gdk-pixbuf:2
        x11-libs/gtk+:2
        x11-libs/libX11:0
        x11-libs/libxcb:0/1.12
        x11-libs/libXcomposite:0
        x11-libs/libXcursor:0
        x11-libs/libXdamage:0
        x11-libs/libXext:0
        x11-libs/libXfixes:0
        x11-libs/libXi:0
        x11-libs/libxkbfile:0
        x11-libs/libXrandr:0
        x11-libs/libXrender:0
        x11-libs/libXScrnSaver:0
        x11-libs/libXtst:0
        x11-libs/pango:0"
RDEPEND="${DEPEND}"

MY_PN="simplenote"
S="${WORKDIR}/Simplenote-linux-${PV}-x64"

src_install() {
		dodir /opt/${PN}
		cp -rT "${S}/" "${D}/opt/simplenote/" || die "install failed!"
        dosym "${D}/opt/simplenote/simplenote" usr/bin/${PN}
}
