{ lib
, buildPythonPackage
, fetchFromGitHub
, hatchling
, requests
, starlette
}:

buildPythonPackage rec {
  pname = "starlette-testclient";
  version = "0.3.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "Kludex";
    repo = "starlette-testclient";
    rev = version;
    hash = "sha256-Ju4OpxaZiSvhp/upJyFLZqnkU/3eMtRj1nbxBavmWZo=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    requests
    starlette
  ];

  pythonImportsCheck = [ "starlette.testclient" ];

  meta = with lib; {
    description = "A backport of Starlette's TestClient using requests";
    homepage = "https://github.com/Kludex/starlette-testclient";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
