{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonPackage rec {
  pname = "schemathesis";
  version = "3.20.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "schemathesis";
    repo = "schemathesis";
    rev = "v${version}";
    hash = "sha256-QrG4jteAdpaM7GrtVpnmwIc/kGQN5IuMPSkhUJdTuiQ=";
  };

  nativeBuildInputs = [
    python3.pkgs.hatchling
  ];

  propagatedBuildInputs = with python3.pkgs; [
    backoff
    click
    colorama
    httpx
    hypothesis
    hypothesis-graphql
    hypothesis-jsonschema
    importlib-metadata
    jsonschema
    junit-xml
    pyrate-limiter
    pytest
    pytest-subtests
    pyyaml
    requests
    starlette
    starlette-testclient
    graphql-core
    tomli
    tomli-w
    typing-extensions
    werkzeug
    yarl
  ];

  passthru.optional-dependencies = with python3.pkgs; {
    cov = [
      coverage
      coverage-enable-subprocess
    ];
    dev = [
      schemathesis
    ];
    docs = [
      sphinx
      sphinx-click
      sphinx-rtd-theme
    ];
    tests = [
      aiohttp
      coverage
      fastapi
      flask
      pydantic
      pytest-asyncio
      pytest-httpserver
      pytest-mock
      pytest-xdist
      strawberry-graphql
      trustme
    ];
  };

  pythonImportsCheck = [ "schemathesis" ];

  meta = with lib; {
    description = "Automate your API Testing: catch crashes, validate specs, and save time";
    homepage = "https://github.com/schemathesis/schemathesis";
    changelog = "https://github.com/schemathesis/schemathesis/blob/${src.rev}/changelog.py";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
