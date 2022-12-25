{ lib
, stdenv
, fetchurl
, meson
, ninja
, pkg-config
, glib
, gobject-introspection
, gnome
, webkitgtk_4_1
, libsoup_3
, libxml2
, libarchive
}:

stdenv.mkDerivation rec {
  pname = "libgepub";
  version = "0.7.0";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "IQpMeJXC6E8BpWglArpej6PqiWrzFw+yWS/OHdpW4C4=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
  ];

  buildInputs = [
    glib
    webkitgtk_4_1
    libsoup_3
    libxml2
    libarchive
  ];

  doCheck = true;

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
      versionPolicy = "none";
    };
  };

  meta = with lib; {
    description = "GObject based library for handling and rendering epub documents";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = teams.gnome.members;
  };
}
