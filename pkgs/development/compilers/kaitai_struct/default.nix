{ lib
, stdenv
, fetchzip
, sbt-with-scala-native
, openjdk8
, makeWrapper
}:


stdenv.mkDerivation rec {
  pname = "kaitai_struct_compiler";
  version = "0.9";

  src = fetchzip {
    url = "https://github.com/kaitai-io/kaitai_struct_compiler/releases/download/${version}/kaitai-struct-compiler-${version}.zip";
    sha256 = "sha256-2HSasigpJDuWNejNVklnpQwaA4MC030S9taF/7YvzgY=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -D $src/bin/kaitai-struct-compiler $out/bin/ksc
    cp -R $src/lib $out/lib
    wrapProgram $out/bin/ksc --prefix PATH : ${lib.makeBinPath [ openjdk8 ] }
  '';

  meta = with lib; {
    homepage = "https://github.com/kaitai-io/kaitai_struct_compiler";
    description =
      "Kaitai Struct: declarative language to generate binary data parsers in C++ / C# / Go / Java / JavaScript / Lua / Perl / PHP / Python / Ruby ";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ luis ];
    platforms = platforms.unix;
  };
}

