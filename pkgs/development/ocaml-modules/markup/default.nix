{ lib, buildDunePackage, fetchFromGitHub, ocaml, uchar, uutf, ounit2 }:

buildDunePackage rec {
  pname = "markup";
  version = "1.0.0";

  useDune2 = true;

  src = fetchFromGitHub {
    owner = "aantron";
    repo = "markup.ml";
    rev = version;
    sha256 = "sha256-yapjqAcn0XSC6Guoj69sXNpLZ2urXANkWhcafpPLEyY=";
  };

  propagatedBuildInputs = [ uchar uutf ];

  checkInputs = [ ounit2 ];
  doCheck = lib.versionAtLeast ocaml.version "4.04";

  meta = with lib; {
    homepage = "https://github.com/aantron/markup.ml/";
    description = "A pair of best-effort parsers implementing the HTML5 and XML specifications";
    license = licenses.mit;
    maintainers = with maintainers; [ gal_bolle ];
  };

}
