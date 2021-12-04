{ lib, stdenv, fetchurl, pkg-config, libmnl }:

stdenv.mkDerivation rec {
  version = "1.2.1";
  pname = "libnftnl";

  src = fetchurl {
    url = "https://netfilter.org/projects/${pname}/files/${pname}-${version}.tar.bz2";
    sha256 = "0z4khm2mnys9mcl8ckwf19cw20jgrv8650nfncy3xcgs2k2aa23m";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libmnl ];

  meta = with lib; {
    description = "A userspace library providing a low-level netlink API to the in-kernel nf_tables subsystem";
    homepage = "http://netfilter.org/projects/libnftnl";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ fpletz ajs124 ];
  };
}
