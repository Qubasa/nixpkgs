{ stdenv, lib, fetchFromGitHub
, asciidoc
, brotli
, cmake
, graphviz
, doxygen
, giflib
, gperftools
, gtest
, libjpeg
, libpng
, libwebp
, openexr
, pkg-config
, python3
, zlib
}:

stdenv.mkDerivation rec {
  pname = "libjxl";
  version = "unstable-2021-06-22";

  src = fetchFromGitHub {
    owner = "libjxl";
    repo = "libjxl";
    rev = "409efe027d6a4a4446b84abe8d7b2fa40409257d";
    sha256 = "1akb6yyp2h4h6mfcqd4bgr3ybcik5v5kdc1rxaqnyjs7fp2f6nvv";
    # There are various submodules in `third_party/`.
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    asciidoc # for docs
    cmake
    graphviz # for docs via doxygen component `dot`
    doxygen # for docs
    gtest
    pkg-config
    python3 # for docs
  ];

  # Functionality not currently provided by this package
  # that the cmake build can apparently use:
  #     OpenGL/GLUT (for Examples -> comparison with sjpeg)
  #     viewer (see `cmakeFlags`)
  #     plugins like for GDK and GIMP (see `cmakeFlags`)

  # Vendored libraries:
  # `libjxl` currently vendors many libraries as git submodules that they
  # might patch often (e.g. test/gmock, see
  # https://github.com/NixOS/nixpkgs/pull/103160#discussion_r519487734).
  # When it has stabilised in the future, we may want to tell the build
  # to use use nixpkgs system libraries.

  # As of writing, libjxl does not point out all its dependencies
  # conclusively in its README or otherwise; they can best be determined
  # by checking the CMake output for "Could NOT find".
  buildInputs = [
    brotli
    giflib
    gperftools # provides `libtcmalloc`
    libjpeg
    libpng
    libwebp
    openexr
    zlib
  ];

  cmakeFlags = [
    # For C dependencies like brotli, which are dynamically linked,
    # we want to use the system libraries, so that we don't have to care about
    # installing their .so files generated by this build.
    # The other C++ dependencies are statically linked in, so there
    # using the vendorered ones is easier.
    "-DJPEGXL_FORCE_SYSTEM_BROTLI=ON"

    # TODO: Update this package to enable this (overridably via an option):
    # Viewer tools for evaluation.
    # "-DJPEGXL_ENABLE_VIEWERS=ON"

    # TODO: Update this package to enable this (overridably via an option):
    # Enable plugins, such as:
    # * the `gdk-pixbuf` one, which allows applications like `eog` to load jpeg-xl files
    # * the `gimp` one, which allows GIMP to load jpeg-xl files
    # "-DJPEGXL_ENABLE_PLUGINS=ON"
  ];

  doCheck = true;

  # The test driver runs a test `LibraryCLinkageTest` which without
  # LD_LIBRARY_PATH setting errors with:
  #     /build/source/build/tools/tests/libjxl_test: error while loading shared libraries: libjxl.so.0
  # The required file is in the build directory (`$PWD`).
  preCheck = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}$PWD
  '';

  meta = with lib; {
    homepage = "https://github.com/libjxl/libjxl";
    description = "JPEG XL image format reference implementation.";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nh2 ];
    platforms = platforms.all;
    broken = stdenv.hostPlatform.isAarch64; # `internal compiler error`, see https://github.com/NixOS/nixpkgs/pull/103160#issuecomment-866388610
  };
}
