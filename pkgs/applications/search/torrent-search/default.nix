{config, lib, pkgs, python37Packages , ... }:

python37Packages.buildPythonApplication rec {
  pname = "torrent-search";
  version = "1.2.5";

  src = pkgs.fetchFromGitHub {
    owner = "rajat19";
    repo = "torrent-crawler";
    rev = "fa482f18e0b42394f3b6d10309edbabb2ed21790";
    sha256 = "16cnh51cn5a65c87spd3izhfqwfj8jr5lfx5i16r92w16a1x8vzd";
  };


  propagatedBuildInputs = with python37Packages; [
    requests
    beautifulsoup4
  ];

  prePatch = ''
    substituteInPlace setup.py \
      --replace 'bs4' \
                'beautifulsoup4'
  '';

  meta = with lib; {
    homepage = https://github.com/rajat19/torrent-crawler;
    description = "Commandline movie torrent searcher";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
