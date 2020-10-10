# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson gnome2 multilib python-single-r1

DESCRIPTION="Screensaver for Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-screensaver/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="debug pam systemd +xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.37.3:2[dbus]
	>=x11-libs/gtk+-3.22:3[introspection]
	>=gnome-extra/cinnamon-desktop-3.5:0=[systemd=]
	>=gnome-base/gsettings-desktop-schemas-0.1.7
	>=gnome-base/libgnomekbd-3.6
	>=dev-libs/dbus-glib-0.78

	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-themes/adwaita-icon-theme

	!systemd? ( sys-auth/elogind )

	${PYTHON_DEPS}

	pam? ( sys-libs/pam )
	systemd? ( >=sys-apps/systemd-31:0= )
	xinerama? ( x11-libs/libXinerama )
"
RDEPEND="${COMMON_DEPEND}
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/xapp[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	')
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35
	gnome-base/gnome-common
	sys-devel/gettext
	virtual/pkgconfig
	x11-base/xorg-proto
"

pkg_setup() {
	python_setup
}

src_prepare() {
	gnome2_src_prepare
}

src_configure() {
	local emesonargs=(
		$(meson_use debug)
		$(meson_use xinerama)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! has_version x11-misc/xscreensaver; then
		elog "${PN} can use screensavers from x11-misc/xscreensaver"
	fi

}
