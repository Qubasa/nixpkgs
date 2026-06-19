{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  util-macros,
  python3,
  libGL,
  libx11,
  x11Support ? !stdenv.hostPlatform.isDarwin,
  testers,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "libepoxy";
  version = "1.5.11-unstable-2026-04-03";

  src = fetchFromGitHub {
    owner = "anholt";
    repo = "libepoxy";
    rev = "d1f952c4565c389d82fd1657153e84e050f35b27";
    hash = "sha256-UasiYqqt7C3uxYZkk8NGIVClSLwwTFdmoVtxcbxCEZg=";
  };

  patches = [ ./libgl-path.patch ];

  postPatch = ''
    patchShebangs src/*.py
  ''
  + lib.optionalString stdenv.hostPlatform.isDarwin ''
    substituteInPlace src/dispatch_common.h --replace-fail "PLATFORM_HAS_GLX 0" "PLATFORM_HAS_GLX 1"
  ''
  # cgl_core and cgl_epoxy_api fail in darwin sandbox and on Hydra (because it's headless?)
  + lib.optionalString stdenv.hostPlatform.isDarwin ''
    substituteInPlace test/meson.build \
      --replace-fail "[ 'cgl_core', [ 'cgl_core.c' ] ]," "" \
      --replace-fail "[ 'cgl_epoxy_api', [ 'cgl_epoxy_api.c' ] ]," ""
  '';

  outputs = [
    "out"
    "dev"
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    util-macros
    python3
  ];

  propagatedBuildInputs =
    lib.optionals (x11Support && !stdenv.hostPlatform.isDarwin) [
      libGL
    ]
    ++ lib.optionals x11Support [
      libx11
    ];

  mesonFlags = [
    "-Degl=${lib.boolToYesNo (x11Support && !stdenv.hostPlatform.isDarwin)}"
    "-Dglx=${lib.boolToYesNo x11Support}"
    "-Dtests=${lib.boolToString finalAttrs.finalPackage.doCheck}"
    "-Dx11=${lib.boolToString x11Support}"
  ];

  env.NIX_CFLAGS_COMPILE = lib.optionalString (
    x11Support && !stdenv.hostPlatform.isDarwin
  ) ''-DLIBGL_PATH="${lib.getLib libGL}/lib"'';

  doCheck = true;

  passthru.tests = {
    pkg-config = testers.hasPkgConfigModules {
      package = finalAttrs.finalPackage;
    };
  };

  meta = {
    description = "Library for handling OpenGL function pointer management";
    homepage = "https://github.com/anholt/libepoxy";
    license = lib.licenses.mit;
    maintainers = [ ];
    platforms = lib.platforms.unix;
    pkgConfigModules = [ "epoxy" ];
  };
})
