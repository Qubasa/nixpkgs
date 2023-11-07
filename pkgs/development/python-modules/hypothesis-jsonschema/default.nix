{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonPackage rec {
  pname = "hypothesis-jsonschema";
  version = "unstable-2023-09-24";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "python-jsonschema";
    repo = "hypothesis-jsonschema";
    rev = "34e6f532031cb6dd664fdd6676f77fcfe482536d";
    hash = "sha256-Qi+QM/1tDoOq9Z+VxAy50hBbj8ofBPSNQmc6g3yp6X8=";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    jsonschema
    hypothesis
  ];

  pythonImportsCheck = [ "hypothesis_jsonschema" ];

  postDist = ''
    rm -r $out/.hypothesis
  '';

  meta = with lib; {
    description = "Tools to generate test data from JSON schemata with Hypothesis";
    homepage = "https://github.com/python-jsonschema/hypothesis-jsonschema";
    changelog = "https://github.com/python-jsonschema/hypothesis-jsonschema/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
  };
}
