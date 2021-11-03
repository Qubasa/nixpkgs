{ stdenv, lib, fetchFromGitHub, cmake
}:

stdenv.mkDerivation rec {
  pname = "reproc";
  version = "14.2.3";

  src = fetchFromGitHub {
    owner = "DaanDeMeyer";
    repo = "reproc";
    rev = "v${version}";
    sha256 = "sha256-bdZ7czkeoSl5znGit0AYQ9D4K8qE2Co+F2Z4jLJuQok=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DBUILD_SHARED_LIBS=ON"
    "-DREPROC++=ON"
    "-DREPROC_TEST=ON"
  ];

  meta = with lib; {
    homepage = "https://github.com/DaanDeMeyer/reproc";
    description = "A cross-platform (C99/C++11) process library";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
