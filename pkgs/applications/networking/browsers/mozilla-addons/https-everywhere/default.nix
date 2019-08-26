{ stdenv, fetchzip  }:

stdenv.mkDerivation rec {
    pname = "https-everywhere-${version}";
    version = "2019.6.27";

    extid = "https-everywhere-eff@eff.org";

    src = fetchzip {
      url = "https://addons.mozilla.org/firefox/downloads/file/3060290/https_everywhere-${version}-an+fx.xpi#${pname}.zip";
      sha256 = "1gif674kkpbihvgvss9zrpx8y43fi5bw6jy42yprhqzvxjanc4an";
      name = "${pname}.zip";
    };


    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/${extid}
      cp -r ${src}/* $out/${extid}
      '';


  meta = {
    description = "Https everywhere browser addon";
    homepage = https://www.eff.org/https-everywhere;
    license = stdenv.lib.licenses.gpl2Plus;
    maintainers = [];
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}

