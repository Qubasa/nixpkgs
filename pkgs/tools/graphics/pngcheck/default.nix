{ lib, stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  pname = "pngcheck";
  version = "3.0.2";

  src = fetchurl {
    url = "mirror://sourceforge/png-mng/pngcheck-${version}.tar.gz";
    sha256 = "sha256-DX4mLyQRb93yhHqM61yS2fXybvtC6f/2PsK7dnYTHKc=";
  };

  hardeningDisable = [ "format" ];

  makefile = "Makefile.unx";
  makeFlags = [ "ZPATH=${zlib.static}/lib" ];

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out/bin/
    cp pngcheck $out/bin/pngcheck
  '';

  meta = {
    homepage = "http://pmt.sourceforge.net/pngcrush";
    description = "Verifies the integrity of PNG, JNG and MNG files";
    license = lib.licenses.free;
    platforms = with lib.platforms; linux;
  };
}
