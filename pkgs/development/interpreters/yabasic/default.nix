{ lib
, stdenv
, fetchurl
, libSM
, libX11
, libXt
, libffi
, ncurses
}:

stdenv.mkDerivation (self: {
  pname = "yabasic";
  version = "2.90.3";

  src = fetchurl {
    url = "http://www.yabasic.de/download/yabasic-${self.version}.tar.gz";
    hash = "sha256-ItmlkraNUE0qlq1RghUJcDq4MHb6HRKNoIRylugjboA=";
  };

  buildInputs = [
    libSM
    libX11
    libXt
    libffi
    ncurses
  ];

  meta = {
    homepage = "http://2484.de/yabasic/";
    description = "Yet another BASIC";
    longDescription = ''
      Yabasic is a traditional basic-interpreter. It comes with goto and various
      loops and allows to define subroutines and libraries. It does simple
      graphics and printing. Yabasic can call out to libraries written in C and
      allows to create standalone programs. Yabasic runs under Unix and Windows
      and has a comprehensive documentation; it is small, simple, open-source
      and free.
   '';
    changelog = "https://2484.de/yabasic/whatsnew.html";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ AndersonTorres ];
    platforms = lib.platforms.all;
  };
})
