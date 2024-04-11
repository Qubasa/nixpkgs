{ stdenv, lib, fetchurl, dpkg }:

let
  arch = {
    "x86_64-linux" = "amd64";
    "aarch64-linux" = "arm64";
  }.${stdenv.hostPlatform.system} or (throw "Unsupported system type: ${stdenv.hostPlatform.system}");

  version = "1.40+15.7-1";
  sha256 = {
    amd64 = "sha256-vnOq+12x/CLDPHEm0H0VBR2qho/lr2BFD8QLAnya8jA=";
    arm64 = "1jh4h3g2nscaqfcbsvv16c2bi2b991gjrbcyfvzx9h93gjd9ks9y";
  }.${arch};

in

stdenv.mkDerivation rec {
  pname = "shim-signed";
  inherit version;

  src = fetchurl {
    url = "http://ftp.debian.org/debian/pool/main/s/shim-signed/shim-signed_${version}_${arch}.deb";
    inherit sha256;
  };

  nativeBuildInputs = [ dpkg ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out
    cp -r * $out/
  '';

  meta = {
    description = "Secure Boot chain-loading bootloader (Microsoft-signed binary)";
    homepage = "https://packages.debian.org/sid/shim-signed";
    maintainers = [ lib.maintainers.qubasa ];
    license = lib.licenses.bsd1; 
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}

