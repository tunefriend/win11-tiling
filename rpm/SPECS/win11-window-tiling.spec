Name:           win11-window-tiling
Version:        1.0.0
Release:        1%{?dist}
Summary:        Windows 11-style automatic window tiling for Linux desktops

License:        MIT AND GPL-3.0-or-later
URL:            https://github.com/domferr/tilingshell
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

# Debian-hosted rpmbuild may relocate %{buildroot}/usr; keep paths intact.
%define __brp_compress %{nil}

Requires:       python3
Requires:       dbus
Requires:       xorg-x11-utils
Requires:       unzip
Requires:       bash

Recommends:     wmctrl
Recommends:     xdotool
Recommends:     xbindkeys
Recommends:     gnome-extensions
Recommends:     plasma-workspace
Recommends:     kwin

%description
Brings Windows 11 Snap Layouts, Snap Assist, and keyboard shortcuts
to Linux desktops. Automatically configures the best tiling solution
for your desktop environment:

 * GNOME: Tiling Shell extension (Snap Assistant, Fancy Zones)
 * KDE Plasma 6: KZones KWin script + Win11 keyboard shortcuts
 * X11 fallback: wmctrl-based tiling with Super+Arrow hotkeys

Run 'win11-tiling-setup' after install to activate for your session.

%prep
%autosetup -n %{name}-%{version}

%build
# noarch shell scripts and bundled extension archives

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}
cp -a usr %{buildroot}/

%post
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database -q %{_datadir}/applications 2>/dev/null || true
fi
echo ""
echo "  win11-window-tiling installed successfully!"
echo ""
echo "  Run 'win11-tiling-setup' to enable Windows 11-style tiling."
echo "  You may need to log out and back in after setup."
echo ""

%preun
if [ "$1" -eq 0 ] && [ -x %{_bindir}/win11-tiling-setup ]; then
    %{_bindir}/win11-tiling-setup --uninstall 2>/dev/null || true
fi

%files
%{_datadir}/doc/win11-window-tiling/README
%{_bindir}/win11-tile
%{_bindir}/win11-tiling-setup
%{_datadir}/win11-tiling/

%changelog
* Sun Jun 28 2026 Local Build <local@localhost> - 1.0.0-1
- Initial RPM release for Fedora and RPM-based distributions