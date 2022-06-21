{ lib, stdenv, fetchurl }:

# Note: this package is used for bootstrapping fetchurl, and thus
# cannot use fetchpatch! All mutable patches (generated by GitHub or
# cgit) that are needed here should be included directly in Nixpkgs as
# files.

stdenv.mkDerivation rec {
  pname = "patchelf";
  version = "0.14.5";

  src = fetchurl {
    url = "https://github.com/NixOS/${pname}/releases/download/${version}/${pname}-${version}.tar.bz2";
    sha256 = "sha256-uaRvKYkyLrifpPYjfiCDbFe0VapDoyVF6gk7Qx2YL1w=";
  };

  strictDeps = true;
  setupHook = [ ./setup-hook.sh ];

  enableParallelBuilding = true;

  # fails 8 out of 24 tests, problems when loading libc.so.6
  doCheck = stdenv.name == "stdenv-linux";

  meta = with lib; {
    homepage = "https://github.com/NixOS/patchelf";
    license = licenses.gpl3Plus;
    description = "A small utility to modify the dynamic linker and RPATH of ELF executables";
    maintainers = [ maintainers.eelco ];
    platforms = platforms.all;
  };
}
