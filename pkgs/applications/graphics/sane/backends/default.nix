{ stdenv, lib, fetchurl, fetchpatch, runtimeShell, buildPackages
, gettext, pkg-config, python3
, avahi, libgphoto2, libieee1284, libjpeg, libpng, libtiff, libusb1, libv4l, net-snmp
, curl, systemd, libxml2, poppler, gawk
, sane-drivers

# List of { src name backend } attibute sets - see installFirmware below:
, extraFirmware ? []

# For backwards compatibility with older setups; use extraFirmware instead:
, gt68xxFirmware ? null, snapscanFirmware ? null

# Not included by default, scan snap drivers require fetching of unfree binaries.
, scanSnapDriversUnfree ? false, scanSnapDriversPackage ? sane-drivers.epjitsu
}:

stdenv.mkDerivation {
  pname = "sane-backends";
  version = "1.1.1";

  src = fetchurl {
    # raw checkouts of the repo do not work because, the configure script is
    # only functional in manually uploaded release tarballs.
    # https://gitlab.com/sane-project/backends/-/issues/440
    # unfortunately this make the url unpredictable on update, to find the link
    # go to https://gitlab.com/sane-project/backends/-/releases and choose
    # the link under the heading "Other".
    url = "https://gitlab.com/sane-project/backends/uploads/7d30fab4e115029d91027b6a58d64b43/sane-backends-1.1.1.tar.gz";
    sha256 = "sha256-3UsEw3pC8UxGGejupqlX9MfGF/5Z4yrihys3OUCotgM=";
  };

  patches = [
    # sane-desc will be used in postInstall so compile it for build
    # https://github.com/void-linux/void-packages/blob/master/srcpkgs/sane/patches/sane-desc-cross.patch
    (fetchpatch {
      name = "compile-sane-desc-for-build.patch";
      url = "https://raw.githubusercontent.com/void-linux/void-packages/4b97cd2fb4ec38712544438c2491b6d7d5ab334a/srcpkgs/sane/patches/sane-desc-cross.patch";
      sha256 = "sha256-y6BOXnOJBSTqvRp6LwAucqaqv+OLLyhCS/tXfLpnAPI=";
    })
    # generate hwdb entries for scanners handled by other backends like epkowa
    # https://gitlab.com/sane-project/backends/-/issues/619
    ./sane-desc-generate-entries-unsupported-scanners.patch
  ];

  postPatch = ''
    # related to the compile-sane-desc-for-build
    substituteInPlace tools/Makefile.in \
      --replace 'cc -I' '$(CC_FOR_BUILD) -I'
  '';

  outputs = [ "out" "doc" "man" ];

  depsBuildBuild = [ buildPackages.stdenv.cc ];

  nativeBuildInputs = [
    gettext
    pkg-config
    python3
  ];

  buildInputs = [
    avahi
    libgphoto2
    libjpeg
    libpng
    libtiff
    libusb1
    curl
    libxml2
    poppler
    gawk
  ] ++ lib.optionals stdenv.isLinux [
    libieee1284
    libv4l
    net-snmp
    systemd
  ];

  enableParallelBuilding = true;

  configureFlags =
    lib.optional (avahi != null)   "--with-avahi"
    ++ lib.optional (libusb1 != null) "--with-usb"
  ;

  # autoconf check for HAVE_MMAP is never set on cross compilation.
  # The pieusb backend fails compilation if HAVE_MMAP is not set.
  buildFlags = lib.optionals (stdenv.hostPlatform != stdenv.buildPlatform) [ "CFLAGS=-DHAVE_MMAP=${if stdenv.hostPlatform.isLinux then "1" else "0"}" ];

  postInstall = let

    compatFirmware = extraFirmware
      ++ lib.optional (gt68xxFirmware != null) {
        src = gt68xxFirmware.fw;
        inherit (gt68xxFirmware) name;
        backend = "gt68xx";
      }
      ++ lib.optional (snapscanFirmware != null) {
        src = snapscanFirmware;
        name = "your-firmwarefile.bin";
        backend = "snapscan";
      };

    installFirmware = f: ''
      mkdir -p $out/share/sane/${f.backend}
      ln -sv ${f.src} $out/share/sane/${f.backend}/${f.name}
    '';

  in ''
    mkdir -p $out/etc/udev/rules.d/ $out/etc/udev/hwdb.d
    ./tools/sane-desc -m udev+hwdb -s doc/descriptions:doc/descriptions-external > $out/etc/udev/rules.d/49-libsane.rules
    ./tools/sane-desc -m udev+hwdb -s doc/descriptions -m hwdb > $out/etc/udev/hwdb.d/20-sane.hwdb
    # the created 49-libsane references /bin/sh
    substituteInPlace $out/etc/udev/rules.d/49-libsane.rules \
      --replace "RUN+=\"/bin/sh" "RUN+=\"${runtimeShell}"

    substituteInPlace $out/lib/libsane.la \
      --replace "-ljpeg" "-L${lib.getLib libjpeg}/lib -ljpeg"

    # net.conf conflicts with the file generated by the nixos module
    rm $out/etc/sane.d/net.conf

  ''
  + lib.optionalString scanSnapDriversUnfree ''
    # the ScanSnap drivers live under the epjitsu subdirectory, which was already created by the build but is empty.
    rmdir $out/share/sane/epjitsu
    ln -svT ${scanSnapDriversPackage} $out/share/sane/epjitsu
  ''
  + lib.concatStrings (builtins.map installFirmware compatFirmware);

  meta = with lib; {
    description = "SANE (Scanner Access Now Easy) backends";
    longDescription = ''
      Collection of open-source SANE backends (device drivers).
      SANE is a universal scanner interface providing standardized access to
      any raster image scanner hardware: flatbed scanners, hand-held scanners,
      video- and still-cameras, frame-grabbers, etc. For a list of supported
      scanners, see http://www.sane-project.org/sane-backends.html.
    '';
    homepage = "http://www.sane-project.org/";
    license = licenses.gpl2Plus;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.symphorien ];
  };
}
