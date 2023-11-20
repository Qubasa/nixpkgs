{ lib
, buildPythonPackage
, fetchFromGitHub
, python3
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "broadcaster";
  version = "0.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "encode";
    repo = "broadcaster";
    rev = "377b4043814ac88a21255af1cc12d5650c785082";
    hash = "sha256-Bno+SXFrLprfN8798djI4GiUWkN5eZsOhxO/e+Ujv+I=";
  };

  propagatedBuildInputs = with python3.pkgs; [
      hatchling
      anyio
      asyncpg
      aiokafka
      typing-extensions

  ];
  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
    pytest-asyncio
  ];

  disabledTests = [
    # Tests that try to download files
    "test_redis"
    "test_kafka"
    "test_postgres"
  ];

  pythonImportsCheck = [ "broadcaster" ];

  meta = with lib; {
    description = "Broadcast channels for async web apps";
    homepage = "https://github.com/encode/broadcaster";
    license = with licenses; [ ];
    maintainers = with maintainers; [ ];
  };
}
