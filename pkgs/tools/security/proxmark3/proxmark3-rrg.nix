{ lib, mkDerivation, fetchFromGitHub, pkg-config, gcc-arm-embedded, bluez5
, readline

, hardwarePlatform ? "PM3RDV4"

, hardwarePlatformExtras ? "" }:

mkDerivation rec {
  pname = "proxmark3-rrg";
  version = "4.13441";

  src = fetchFromGitHub {
    owner = "RfidResearchGroup";
    repo = "proxmark3";
    rev = "v${version}";
    sha256 = "1ffchqnm8023zcm4ywncf1j6076s78226h72m9dfmi0zbj3pbj4m";
  };

  nativeBuildInputs = [ pkg-config gcc-arm-embedded ];
  buildInputs = [ bluez5 readline ];

  makeFlags = [
    "PLATFORM=${hardwarePlatform}"
    "PLATFORM_EXTRAS=${hardwarePlatformExtras}"
  ];

  installPhase = ''
    install -Dt $out/bin client/proxmark3
    install -Dt $out/firmware bootrom/obj/bootrom.elf armsrc/obj/fullimage.elf
  '';

  meta = with lib; {
    description = "Client for proxmark3, powerful general purpose RFID tool";
    homepage = "https://rfidresearchgroup.com/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ nyanotech ];
  };
}
