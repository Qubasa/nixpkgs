{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  python3,
  aemu,
  libdrm,
  libglvnd,
  vulkan-headers,
  vulkan-loader,
  libx11,
  libxcb,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gfxstream";
  version = "0.1.2-unstable-2026-06-18";

  src = fetchFromGitHub {
    owner = "google";
    repo = "gfxstream";
    rev = "09f3b39fc5a9085d769ffcf5448104e2162104e0";
    hash = "sha256-/TSQJcATB3Wp712R/xUpD2i480HNmQ2UTDDgylHAF9E=";
  };

  # Ensure that meson can find an Objective-C compiler on Darwin.
  postPatch = lib.optionalString stdenv.hostPlatform.isDarwin ''
    substituteInPlace meson.build \
      --replace-fail "project('gfxstream_backend', 'cpp', 'c'" "project('gfxstream_backend', 'cpp', 'c', 'objc'"
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
  ];
  buildInputs = [
    aemu
    libglvnd
    vulkan-headers
    vulkan-loader
    libx11
    libxcb
  ]
  ++ lib.optionals (lib.meta.availableOn stdenv.hostPlatform libdrm) [ libdrm ];

  env = lib.optionalAttrs stdenv.hostPlatform.isDarwin {
    NIX_LDFLAGS = toString [
      "-framework Cocoa"
      "-framework IOKit"
      "-framework IOSurface"
      "-framework OpenGL"
      "-framework QuartzCore"
      "-needed-lvulkan"
    ];
  };

  # dlopens libvulkan.
  preConfigure = lib.optionalString (!stdenv.hostPlatform.isDarwin) ''
    mesonFlagsArray=(-Dcpp_link_args="-Wl,--push-state -Wl,--no-as-needed -lvulkan -Wl,--pop-state")
  '';

  meta = {
    homepage = "https://android.googlesource.com/platform/hardware/google/gfxstream";
    description = "Graphics Streaming Kit";
    license = lib.licenses.free; # https://android.googlesource.com/platform/hardware/google/gfxstream/+/refs/heads/main/LICENSE
    maintainers = with lib.maintainers; [ qyliss ];
    platforms = aemu.meta.platforms;
  };
})
