{ lib
, nix-update-script
, rustPlatform
, fetchFromGitHub
, installShellFiles
, stdenv
, coreutils
, bash
, pkg-config
, openssl
, direnv
, Security
, SystemConfiguration
}:

rustPlatform.buildRustPackage rec {
  pname = "rtx";
  version = "2023.11.2";

  src = fetchFromGitHub {
    owner = "jdxcode";
    repo = "rtx";
    rev = "v${version}";
    hash = "sha256-OdqHyxqufJJTfP7frjLKf5R0WNySDyZc7Sh0Mpdord0=";
  };

  cargoHash = "sha256-KOte3zmJllrMp6OaKuFtUsRjdRKlSAxdJp1iJEOPcF0=";

  nativeBuildInputs = [ installShellFiles pkg-config ];
  buildInputs = [ openssl  ] ++ lib.optionals stdenv.isDarwin [ Security SystemConfiguration ];

  postPatch = ''
    patchShebangs --build ./test/data/plugins/**/bin/* ./src/fake_asdf.rs ./src/cli/reshim.rs

    substituteInPlace ./src/env_diff.rs \
      --replace '"bash"' '"${bash}/bin/bash"'

    substituteInPlace ./src/cli/direnv/exec.rs \
      --replace '"env"' '"${coreutils}/bin/env"' \
      --replace 'cmd!("direnv"' 'cmd!("${direnv}/bin/direnv"'
  '';

  checkFlags = [
    # Requires .git directory to be present
    "--skip=cli::plugins::ls::tests::test_plugin_list_urls"
  ];
  cargoTestFlags = [ "--all-features" ];
  # some tests access the same folders, don't test in parallel to avoid race conditions
  dontUseCargoParallelTests = true;

  postInstall = ''
    installManPage ./man/man1/rtx.1

    installShellCompletion \
      --bash ./completions/rtx.bash \
      --fish ./completions/rtx.fish \
      --zsh ./completions/_rtx
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    homepage = "https://github.com/jdxcode/rtx";
    description = "Polyglot runtime manager (asdf rust clone)";
    changelog = "https://github.com/jdxcode/rtx/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ konradmalik ];
    mainProgram = "rtx";
  };
}
