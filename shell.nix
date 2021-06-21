  { pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = with pkgs; [
      python3
      (with python38Packages; [
        pip
        ipython
      ])

    ];
    shellHook = "export HISTFILE=${toString ./.history}";
  }
