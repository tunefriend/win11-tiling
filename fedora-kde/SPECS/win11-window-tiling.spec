Name:           win11-window-tiling
Version:        1.0.0
Release:        1.fc41kde%{?dist}
Summary:        Windows 11-style window tiling for Fedora KDE Plasma

License:        MIT AND GPL-3.0-or-later
URL:            https://github.com/gerritdevriese/kzones
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

%define __brp_compress %{nil}

# Fedora KDE Plasma Spin — KWin + KZones only.
Requires:       plasma-workspace
Requires:       kwin
Requires:       dbus
Requires:       bash

%description
Windows 11-style window tiling for Fedora KDE Plasma Spin.

Installs and configures the KZones KWin script for zone-based window
snapping and Windows 11-style Super+Arrow keyboard shortcuts.

Built specifically for Fedora KDE Plasma. After install, run
'win11-tiling-setup' and log out and back in.

%prep
%autosetup -n %{name}-%{version}

%build
# KZones KWin script and setup scripts only

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}
cp -a usr %{buildroot}/

%post
echo ""
echo "  win11-window-tiling (Fedora KDE Plasma) installed!"
echo ""
echo "  Run 'win11-tiling-setup' to enable KZones."
echo "  Log out and back in after setup."
echo ""

%preun
if [ "$1" -eq 0 ] && [ -x %{_bindir}/win11-tiling-setup ]; then
    %{_bindir}/win11-tiling-setup --uninstall 2>/dev/null || true
fi

%files
%{_datadir}/doc/win11-window-tiling/README
%{_bindir}/win11-tile
%{_bindir}/win11-tiling-setup
%{_datadir}/win11-tiling/kde/
%{_datadir}/win11-tiling/scripts/setup-kde.sh
%{_datadir}/win11-tiling/scripts/detect-desktop.sh

%changelog
* Sun Jun 28 2026 Local Build <local@localhost> - 1.0.0-1.fc41kde
- Fedora KDE Plasma edition: KZones KWin script only