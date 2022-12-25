{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "claws";
  version = "0.4.1";

  src = fetchFromGitHub {
    rev = version;
    owner = "thehowl";
    repo = pname;
    sha256 = "sha256-3zzUBeYfu9x3vRGX1DionLnAs1e44tFj8Z1dpVwjdCg=";
  };

  vendorSha256 = "sha256-FP+3Rw5IdCahhx9giQrpepMMtF1pWcyjNglrlu9ju0Q=";

  ldflags = [ "-s" "-w" ];

  meta = with lib; {
    homepage = "https://github.com/thehowl/claws";
    description = "Interactive command line client for testing websocket servers";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ aaronjheng ];
  };
}
