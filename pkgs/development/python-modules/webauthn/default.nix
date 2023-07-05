{ lib
, buildPythonPackage
, fetchFromGitHub
, asn1crypto
, cbor2
, pythonOlder
, pydantic
, pyopenssl
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "webauthn";
  version = "1.8.1";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "duo-labs";
    repo = "py_webauthn";
    rev = "refs/tags/v${version}";
    hash = "sha256-ivPLS+kh/H8qLojgc5qh1ndPzSZbzbnm9E+LQGq8+Xs=";
  };

  propagatedBuildInputs = [
    asn1crypto
    cbor2
    pydantic
    pyopenssl
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "webauthn"
  ];

  disabledTests = [
    # TypeError: X509StoreContextError.__init__() missing 1 required...
    "test_throws_on_bad_root_cert"
  ];

  meta = with lib; {
    description = "Implementation of the WebAuthn API";
    homepage = "https://github.com/duo-labs/py_webauthn";
    changelog = "https://github.com/duo-labs/py_webauthn/blob/v${version}/CHANGELOG.md";
    license = licenses.bsd3;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
