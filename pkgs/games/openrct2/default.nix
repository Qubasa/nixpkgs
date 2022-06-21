{ lib, stdenv, fetchFromGitHub
, SDL2, cmake, curl, duktape, fontconfig, freetype, icu, jansson, libGLU
, libiconv, libpng, libpthreadstubs, libzip, nlohmann_json, openssl, pkg-config
, speexdsp, zlib
}:

let
  openrct2-version = "0.4.0";

  # Those versions MUST match the pinned versions within the CMakeLists.txt
  # file. The REPLAYS repository from the CMakeLists.txt is not necessary.
  objects-version = "1.2.7";
  title-sequences-version = "0.4.0";

  openrct2-src = fetchFromGitHub {
    owner = "OpenRCT2";
    repo = "OpenRCT2";
    rev = "v${openrct2-version}";
    sha256 = "sha256-4MDOLOPsKzk1vb1o/G90/NTyYJWBSrGRX6ZJETbBIaI=";
  };

  objects-src = fetchFromGitHub {
    owner = "OpenRCT2";
    repo = "objects";
    rev = "v${objects-version}";
    sha256 = "sha256-R4+rEdGdvYwFrkm/S3+zXmU+UDam51dI/pWKmFXNrbE=";
  };

  title-sequences-src = fetchFromGitHub {
    owner = "OpenRCT2";
    repo = "title-sequences";
    rev = "v${title-sequences-version}";
    sha256 = "sha256-anqCZkhYoaxPu3MYCYSsFFngOmPp2wnx2MGb0hj6W5U=";
  };
in
stdenv.mkDerivation {
  pname = "openrct2";
  version = openrct2-version;

  src = openrct2-src;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    SDL2
    curl
    duktape
    fontconfig
    freetype
    icu
    jansson
    libGLU
    libiconv
    libpng
    libpthreadstubs
    libzip
    nlohmann_json
    openssl
    speexdsp
    zlib
  ];

  cmakeFlags = [
    "-DDOWNLOAD_OBJECTS=OFF"
    "-DDOWNLOAD_TITLE_SEQUENCES=OFF"
  ];

  postUnpack = ''
    cp -r ${objects-src}         $sourceRoot/data/object
    cp -r ${title-sequences-src} $sourceRoot/data/sequence
  '';

  preConfigure = ''
    # Verify that the correct version of each third party repository is used.

    grep -q '^set(OBJECTS_VERSION "${objects-version}")$' CMakeLists.txt \
      || (echo "OBJECTS_VERSION differs!"; exit 1)
    grep -q '^set(TITLE_SEQUENCE_VERSION "${title-sequences-version}")$' CMakeLists.txt \
      || (echo "TITLE_SEQUENCE_VERSION differs!"; exit 1)
  '';

  preFixup = "ln -s $out/share/openrct2 $out/bin/data";

  meta = with lib; {
    description = "Open source re-implementation of RollerCoaster Tycoon 2 (original game required)";
    homepage = "https://openrct2.io/";
    downloadPage = "https://github.com/OpenRCT2/OpenRCT2/releases";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ oxzi ];
  };
}
