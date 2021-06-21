{ stdenv
, fetchurl
, autoPatchelfHook
, lib
, wrapQtAppsHook
, libglvnd
, python39Full
, libsForQt513
, gcc-unwrapped
, libusb1
, libudev
, zlib 
, fontconfig
, glib
, freetype
, xlibs
, libffi
}:
stdenv.mkDerivation rec {
  pname = "talon";
  version = "0.1.5";
  rev = "v${lib.versions.major version}";

  src = fetchurl {
    url = "https://talonvoice.com/dl/latest/talon-linux.tar.xz";
    sha256 = "08ssgq5j3lyb5q6nmpi5rsf30fr46grqjs1pdxsakf8m26fgysyr";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    wrapQtAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    libglvnd.out 
    python39Full.out
    libsForQt513.full.out
    gcc-unwrapped.lib
    libusb1.out
    libudev.out
    zlib.out 
    stdenv.cc.cc 
    fontconfig.lib 
    glib.out 
    freetype.out 
    xlibs.libX11.out
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib
    mkdir -p $out/share

    cp $sourceRoot/talon/talon $out/bin/talon
    cp \
      --archive \
      $sourceRoot/talon/lib/libicudata.so* \
      $sourceRoot/talon/lib/libicui18n.so* \
      $sourceRoot/talon/lib/libicuuc.so* \
      $sourceRoot/talon/lib/libSkiaSharp.so* \
      $sourceRoot/talon/lib/libusb-1.0.so* \
      $sourceRoot/talon/lib/libw2l.so* \
      $out/lib
      #$sourceRoot/talon/lib/libQt5Core.so* \
      #$sourceRoot/talon/lib/libQt5DBus.so* \
      #$sourceRoot/talon/lib/libQt5Gui.so* \
      #$sourceRoot/talon/lib/libQt5WaylandClient.so* \
      #$sourceRoot/talon/lib/libQt5Widgets.so* \
      #$sourceRoot/talon/lib/libQt5XcbQpa.so* \


    # we already ship libffi.so.7
    ln -s ${lib.getLib libffi}/lib/libffi.so $out/lib/libffi.so.7

    #cp -r $sourceRoot/talon/resources $out/bin

    runHook postInstall
  '';


  meta = with lib; {
    homepage = "https://talonvoice.com/";
    description = "Voice coding application";
    license = licenses.unfree;
    maintainers = with maintainers; [
      luis
    ];
    platforms = platforms.linux;
  };
}
