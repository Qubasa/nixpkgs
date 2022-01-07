{ lib
, buildPythonPackage
, fetchFromGitHub
, pytest
, bashlex
, click
, shutilwhich
, gcc
, coreutils
}:

buildPythonPackage rec {
  pname = "compdb";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "Sarcasm";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nFAgTrup6V5oE+LP4UWDOCgTVCv2v9HbQbkGW+oDnTg=";
  };

  # fix the tests
  #patchPhase = ''
  #  substituteInPlace tests/data/multiple_commands_oneline.txt \
  #                    --replace /bin/echo ${coreutils}/bin/echo
  #'';

  checkInputs = [ pytest gcc coreutils ];
  propagatedBuildInputs = [ click bashlex shutilwhich ];

  checkPhase = ''
    pytest
  '';

  meta = with lib; {
    description = "The compilation database Swiss army knife ";
    license = licenses.mit;
    homepage = "https://github.com/Sarcasm/compdb";
    maintainers = with maintainers; [ luis ];
  };
}
