{ lib
, buildPythonPackage
, fetchFromGitHub
, hatchling
, graphql-core
, hypothesis
, coverage
, pytest
, pytest-xdist
}:

buildPythonPackage rec {
  pname = "hypothesis-graphql";
  version = "0.10.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "Stranger6667";
    repo = "hypothesis-graphql";
    rev = "v${version}";
    hash = "sha256-p1+fn7VmXr9XZ1e8UE5sig4+3cksbrG2J7yPlMW5utA=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    graphql-core
    hypothesis
  ];



  pythonImportsCheck = [ "hypothesis_graphql" ];

  meta = with lib; {
    description = "Generate arbitrary queries matching your GraphQL schema, and use them to verify your backend implementation";
    homepage = "https://github.com/Stranger6667/hypothesis-graphql";
    changelog = "https://github.com/Stranger6667/hypothesis-graphql/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
