{ stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  libxml2,
  tlf,
  zlib,
  libffi,
  elfutils,
  libstdcxx5,
}:

stdenv.mkDerivation rec {
    pname = "aocc";
    version = "2.1.0";

    src = fetchurl {
        url = "https://developer.amd.com/aocc-compiler-eula/";
        sha256 = "084xgg6xnrjrzl1iyqyrb51f7x2jnmpzdd39ad81dn10db99b405";
        curlOpts = "--data amd_developer_central_nonce=b9697d2a38&_wp_http_referer=%2Faocc-compiler-eula%2F&f=YW9jYy1jb21waWxlci0yLjEuMC50YXI%3D";
        name = "aocc-compiler.tar";
    };

    sourceRoot = ".";

    nativeBuildInputs = [
       autoPatchelfHook
    ];

    LIBRARY_PATH = (stdenv.lib.makeLibraryPath [ zlib libstdcxx5 gcc-unwrapped ]);

    buildInputs = [
       gcc-unwrapped
       libxml2
       zlib
       tlf
       libffi
       elfutils
    ];

    installPhase = ''
        runHook preInstall
    
        mkdir -p $out/bin
        mkdir -p $out/lib
        mkdir -p $out/lib32
        mkdir -p $out/include
        mkdir -p $out/share

        srcRoot="$sourceRoot/aocc-compiler-${version}"
        cp --archive \
            $srcRoot/bin/* $out/bin 
        cp --archive \
            $srcRoot/share/* $out/share 
        cp --archive \
            $srcRoot/include/* $out/include 
        cp --archive \
            $srcRoot/lib/* $out/lib 
            

        runHook postInstall
    '';
}
