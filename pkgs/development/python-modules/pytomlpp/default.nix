{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pybind11
, pytestCheckHook
, python-dateutil
, doxygen
, python
, pelican
, matplotlib
}:

buildPythonPackage rec {
  pname = "pytomlpp";
  version = "1.0.6";

  src = fetchFromGitHub {
    owner = "bobfang1992";
    repo = pname;
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-QyjIJCSgiSKjqMBvCbOlWYx6rBbKIoDvXez2YnYaPUo=";
  };

  buildInputs = [ pybind11 ];

  checkInputs = [
    pytestCheckHook

    python-dateutil
    doxygen
    python
    pelican
    matplotlib
  ];

  # pelican requires > 2.7
  doCheck = !pythonOlder "3.6";

  preCheck = ''
    cd tests
  '';

  pythonImportsCheck = [ "pytomlpp" ];

  meta = with lib; {
    description = "A python wrapper for tomlplusplus";
    homepage = "https://github.com/bobfang1992/pytomlpp";
    license = licenses.mit;
    maintainers = with maintainers; [ evils ];
  };
}
