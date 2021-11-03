{ lib
, stdenv
, buildPythonPackage
, fetchFromGitHub
, isPy3k
, pytestCheckHook
, mock
}:

buildPythonPackage rec {
  pname = "paho-mqtt";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.python";
    rev = "v${version}";
    sha256 = "sha256-9nH6xROVpmI+iTKXfwv2Ar1PAmWbEunI3HO0pZyK6Rg=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "pylama" "" \
      --replace "'pytest-runner'" ""
    substituteInPlace setup.cfg \
      --replace "--pylama" ""
  '';

  checkInputs = [
    pytestCheckHook
  ] ++ lib.optional (!isPy3k) [
    mock
  ];

  doCheck = !stdenv.isDarwin;

  pythonImportsCheck = [
    "paho.mqtt"
  ];

  meta = with lib; {
    description = "MQTT version 3.1.1 client class";
    homepage = "https://eclipse.org/paho";
    license = licenses.epl10;
    maintainers = with maintainers; [ mog dotlambda ];
  };
}
