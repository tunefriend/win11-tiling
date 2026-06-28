Name:           win11-window-tiling
Version:        1.0.0
Release:        1.fc41%{?dist}
Summary:        Windows 11-style window tiling for Fedora Workstation (GNOME)

License:        MIT AND GPL-3.0-or-later
URL:            https://github.com/domferr/tilingshell
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

# Cross-build safety when rpmbuild runs outside Fedora.
%define __brp_compress %{nil}

# Fedora Workstation ships GNOME; this package targets that stack only.
Requires:       gnome-shell
Requires:       gnome-extensions
Requires:       unzip
Requires:       dbus
Requires:       bash

%description
Windows 11-style window tiling for Fedora Workstation.

Installs and configures the Tiling Shell GNOME extension with Snap
Assistant, Fancy Zones layouts, and Super+Arrow keyboard shortcuts.

Built specifically for Fedora Workstation (GNOME). After install, run
'win11-tiling-setup' and log out and back in.

%prep
%autosetup -n %{name}-%{version}

%build
# GNOME extension archives and setup scripts only

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}
cp -a usr %{buildroot}/

%post
echo ""
echo "  win11-window-tiling (Fedora Workstation) installed!"
echo ""
echo "  Run 'win11-tiling-setup' to enable Tiling Shell."
echo "  Log out and back in after setup."
echo ""

%preun
if [ "$1" -eq 0 ] && [ -x %{_bindir}/win11-tiling-setup ]; then
    %{_bindir}/win11-tiling-setup --uninstall 2>/dev/null || true
fi

%files
%{_datadir}/doc/win11-window-tiling/README
%{_bindir}/win11-tiling-setup
%{_datadir}/win11-tiling/gnome/
%{_datadir}/win11-tiling/scripts/setup-gnome.sh
%{_datadir}/win11-tiling/scripts/detect-desktop.sh

%changelog
* Sun Jun 28 2026 Local Build <local@localhost> - 1.0.0-1
- Fedora Workstation edition: GNOME Tiling Shell only