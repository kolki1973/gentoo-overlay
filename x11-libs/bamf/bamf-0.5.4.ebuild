# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8,9} )
VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND=vapigen

inherit vala autotools python-r1

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="http://launchpad.net/${PN}/0.5/${PV}/+download/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc +introspection static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	>=x11-libs/libwnck-3.4.7:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	${PYTHON_DEPS}
	dev-libs/libxml2[${PYTHON_USEDEP}]
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=yes
DOCS=(AUTHORS COPYING COPYING.LGPL ChangeLog NEWS README TODO)

src_prepare(){
	sed -i 's/-Werror//' configure.ac
	sed -i 's/tests//' Makefile.am
	eapply "${FILESDIR}/${PN}-0.5.0-disable-gtester2xunit-check.patch"
	eapply "${FILESDIR}/${PN}-0.5.0-remove-desktop-fullname.patch"
	eautoreconf
	vala_src_prepare
	default
}

src_configure() {
	python_setup
	econf \
		--disable-headless-tests \
		--disable-gtktest \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		VALA_API_GEN="${VAPIGEN}"

}
