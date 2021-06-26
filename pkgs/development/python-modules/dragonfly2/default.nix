{ lib, buildPythonPackage, fetchPypi, 
pyperclip, 
regex, 
decorator, 
six,
packaging,
lark-parser-08,
pynput,
psutil,
json-rpc,
werkzeug,
requests,
pytest,
 }:

buildPythonPackage rec {
  pname = "dragonfly2";
  version = "0.31.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-6SShb7AXbDWmdD9bB5Ws0NqmMILQsxh/bI6+zOW/wSo=";
  };

  propagatedBuildInputs = [  
    pyperclip
    regex
    decorator
    six
    packaging
    lark-parser-08
    pynput
    psutil
    json-rpc
    werkzeug
    requests
    pytest
  ];

  doCheck = false;

  meta = with lib; {
    description = "Speech recognition framework";
    homepage = "https://github.com/dictation-toolbox/dragonfly";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ luis ];
    platforms = platforms.linux;
  };
}
