{ stdenv, requireFile, gcc, autoPatchelfHook, freetype,
  fontconfig, kmod, ncurses, coreutils, libxcb, glib, numactl, dbus, libX11, libSM, libICE, libXi, libglvnd, lib}:

stdenv.mkDerivation rec {
    pname = "amd-uprof";
    version = "3.4.502";

    src = let packageName = "AMDuProf_Linux_x64_${version}.tar.bz2"; in requireFile {
        name = packageName;
        sha256 = "891463c0e4f20e1c67a145441e983c863156a52716234cd8d5a96a8d09635ba7";
        message = ''
            The download for this file is behind a EULA acceptance screen you need to accept first,
            Visit https://developer.amd.com/amd-uprof/ and download the tarball, then run the following:
            $ nix-store --add-fixed sha256 ${packageName}
            $ nix-hash --base32 --type sha256 --flat ${packageName}
        '';
    };

    buildInputs = [
        autoPatchelfHook
        freetype
        fontconfig
        gcc
        libxcb
        glib
        numactl
        dbus
        libX11
        libSM
        libICE
        libXi
        libglvnd
        coreutils
        ncurses
        kmod
    ];

    # sed -i -e 's/check_distro$/IS_DISTRO_UBUNTU=1/' ./bin/AMDPowerProfilerDriver.sh
    # sed -i -e 's/check_exe_permission$/# check_exe_permission/' ./bin/AMDPowerProfilerDriver.sh
    # patchShebangs ./bin/AMDPowerProfilerDriver.sh
    # ./bin/AMDPowerProfilerDriver.sh install
    installPhase = ''
    patchShebangs ./bin
    mkdir -p $out/bin
    cp -r ./bin $out/
    '';

    meta = with lib; {
        description = "AMD uProf is a performance analysis tool for applications running on Windows and Linux operating systems. It allows developers to better understand the runtime performance of their application and to identify ways to improve its performance.";
        license = licenses.amd;
        maintainers = [];
        platforms = platforms.linux;
    };
}
