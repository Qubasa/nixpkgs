{ lib
, buildPythonPackage
, fetchFromGitHub
, python3
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "broadcaster";
  version = "0.2.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "encode";
    repo = "broadcaster";
    rev = version;
    hash = "sha256-sb6vOp9AOBs0ld1P3/Uc1jsiw9SUjGOsSdSnyF7IOzI=";
  };

  propagatedBuildInputs = with python3.pkgs; [

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
