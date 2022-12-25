{ lib, stdenv, fetchurl, moltenvk, vulkan-headers, spirv-headers, vulkan-loader, flex, bison }:

#TODO: unstable

stdenv.mkDerivation rec {
  pname = "vkd3d";
  version = "1.5";

  src = fetchurl {
    url = "https://dl.winehq.org/vkd3d/source/vkd3d-${version}.tar.xz";
    sha256 = "sha256-47PDVfRvfL/BnnEKR4vLK+4mel82Dn5kBiOM6lLOLPw=";
  };

  nativeBuildInputs = [ flex bison ];

  buildInputs = [ vulkan-headers spirv-headers ]
    ++ [ (if stdenv.isDarwin then moltenvk else vulkan-loader) ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "A 3d library build on top on Vulkan with a similar api to DirectX 12";
    homepage = "https://source.winehq.org/git/vkd3d.git";
    license = licenses.lgpl21;
    platforms = platforms.unix;
    maintainers = [ maintainers.marius851000 ];
  };
}
