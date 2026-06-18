{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchurl,
  runCommand,
  meson,
  ninja,
  pkg-config,
  rustc,
  rustPlatform,
  rust-bindgen,
  aemu,
  gfxstream,
  libdrm,
  libiconv,
  withGfxstream ? lib.meta.availableOn stdenv.hostPlatform gfxstream,
}:

let
  # The meson build resolves Rust dependencies through subproject wraps that
  # download crate tarballs from crates.io. Provide them offline by populating
  # subprojects/packagecache from the hashes pinned in subprojects/*.wrap.
  crates = [
    {
      n = "anstyle-1.0.11.tar.gz";
      c = "anstyle/1.0.11";
      h = "862ed96ca487e809f1c8e5a8447f6ee2cf102f846893800b20cebdf541fc6bbd";
    }
    {
      n = "bitflags-2.9.1.tar.gz";
      c = "bitflags/2.9.1";
      h = "1b8e56985ec62d17e9c1001dc89c88ecd7dc08e47eba5ec7c29c7b5eeecde967";
    }
    {
      n = "cfg-if-1.0.0.tar.gz";
      c = "cfg-if/1.0.0";
      h = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd";
    }
    {
      n = "clap-4.5.48.tar.gz";
      c = "clap/4.5.48";
      h = "e2134bb3ea021b78629caa971416385309e0131b351b25e01dc16fb54e1b5fae";
    }
    {
      n = "clap_builder-4.5.48.tar.gz";
      c = "clap_builder/4.5.48";
      h = "c2ba64afa3c0a6df7fa517765e31314e983f51dda798ffba27b988194fb65dc9";
    }
    {
      n = "clap_derive-4.5.47.tar.gz";
      c = "clap_derive/4.5.47";
      h = "bbfd7eae0b0f1a6e63d4b13c9c478de77c2eb546fba158ad50b4203dc24b9f9c";
    }
    {
      n = "clap_lex-0.7.5.tar.gz";
      c = "clap_lex/0.7.5";
      h = "b94f61472cee1439c0b966b47e3aca9ae07e45d070759512cd390ea2bebc6675";
    }
    {
      n = "errno-0.3.12.tar.gz";
      c = "errno/0.3.12";
      h = "cea14ef9355e3beab063703aa9dab15afd25f0667c341310c1e5274bb1d0da18";
    }
    {
      n = "heck-0.5.0.tar.gz";
      c = "heck/0.5.0";
      h = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea";
    }
    {
      n = "itoa-1.0.9.tar.gz";
      c = "itoa/1.0.9";
      h = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38";
    }
    {
      n = "libc-0.2.171.tar.gz";
      c = "libc/0.2.171";
      h = "c19937216e9d3aa9956d9bb8dfc0b0c8beb6058fc4f7a4dc4d850edf86a237d6";
    }
    {
      n = "log-0.4.27.tar.gz";
      c = "log/0.4.27";
      h = "13dc2df351e3202783a1fe0d44375f7295ffb4049267b0f3018346dc122a1d94";
    }
    {
      n = "memchr-2.7.5.tar.gz";
      c = "memchr/2.7.5";
      h = "32a282da65faaf38286cf3be983213fcf1d2e2a58700e808f83f4ea9a4804bc0";
    }
    {
      n = "proc-macro2-1.0.86.tar.gz";
      c = "proc-macro2/1.0.86";
      h = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77";
    }
    {
      n = "quote-1.0.35.tar.gz";
      c = "quote/1.0.35";
      h = "291ec9ab5efd934aaf503a6466c5d5251535d108ee747472c3977cc5acc868ef";
    }
    {
      n = "remain-0.2.12.tar.gz";
      c = "remain/0.2.12";
      h = "1ad5e011230cad274d0532460c5ab69828ea47ae75681b42a841663efffaf794";
    }
    {
      n = "rustix-1.1.2.tar.gz";
      c = "rustix/1.1.2";
      h = "cd15f8a2c5551a84d56efdc1cd049089e409ac19a3072d5037a17fd70719ff3e";
    }
    {
      n = "ryu-1.0.15.tar.gz";
      c = "ryu/1.0.15";
      h = "1ad4cc8da4ef723ed60bced201181d83791ad433213d8c24efffda1eec85d741";
    }
    {
      n = "serde-1.0.226.tar.gz";
      c = "serde/1.0.226";
      h = "0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd";
    }
    {
      n = "serde_core-1.0.226.tar.gz";
      c = "serde_core/1.0.226";
      h = "ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4";
    }
    {
      n = "serde_derive-1.0.226.tar.gz";
      c = "serde_derive/1.0.226";
      h = "8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33";
    }
    {
      n = "serde_json-1.0.145.tar.gz";
      c = "serde_json/1.0.145";
      h = "402a6f66d8c709116cf22f558eab210f5a50187f702eb4d7e5ef38d9a7f1c79c";
    }
    {
      n = "syn-2.0.87.tar.gz";
      c = "syn/2.0.87";
      h = "25aa4ce346d03a6dcd68dd8b4010bcb74e54e62c90c573f394c46eae99aba32d";
    }
    {
      n = "thiserror-2.0.11.tar.gz";
      c = "thiserror/2.0.11";
      h = "d452f284b73e6d76dd36758a0c8684b1d5be31f92b89d07fd5822175732206fc";
    }
    {
      n = "thiserror-impl-2.0.11.tar.gz";
      c = "thiserror-impl/2.0.11";
      h = "26afc1baea8a989337eeb52b6e72a039780ce45c3edfcc9c5b9d112feeb173c2";
    }
    {
      n = "unicode-ident-1.0.12.tar.gz";
      c = "unicode-ident/1.0.12";
      h = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b";
    }
    {
      n = "windows-link-0.2.0.tar.gz";
      c = "windows-link/0.2.0";
      h = "45e46c0661abb7180e7b9c281db115305d49ca1709ab8242adf09666d2173c65";
    }
    {
      n = "windows-sys-0.61.1.tar.gz";
      c = "windows-sys/0.61.1";
      h = "6f109e41dd4a3c848907eb83d5a42ea98b3769495597450cf6d153507b166f0f";
    }
    {
      n = "zerocopy-0.8.13.tar.gz";
      c = "zerocopy/0.8.13";
      h = "67914ab451f3bfd2e69e5e9d2ef3858484e7074d63f204fd166ec391b54de21d";
    }
    {
      n = "zerocopy-derive-0.8.13.tar.gz";
      c = "zerocopy-derive/0.8.13";
      h = "7988d73a4303ca289df03316bc490e934accf371af6bc745393cf3c2c5c4f25d";
    }
  ];

  packagecache = runCommand "rutabaga_gfx-packagecache" { } (
    "mkdir -p $out\n"
    + lib.concatMapStringsSep "\n" (
      crate:
      "cp ${
        fetchurl {
          name = crate.n;
          url = "https://crates.io/api/v1/crates/${crate.c}/download";
          sha256 = crate.h;
        }
      } $out/${crate.n}"
    ) crates
  );
in
stdenv.mkDerivation (finalAttrs: {
  pname = "rutabaga_gfx";
  version = "0.1.75";

  src = fetchFromGitHub {
    owner = "magma-gpu";
    repo = "rutabaga_gfx";
    tag = "v${finalAttrs.version}";
    hash = "sha256-d7JLmjKpNadtetvD2ubBrcmsl4TwneGbigO0AA2V9+8=";
  };

  separateDebugInfo = true;

  postPatch = ''
    mkdir -p subprojects/packagecache
    cp ${packagecache}/* subprojects/packagecache/
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    rustc
    rust-bindgen
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    libiconv
  ]
  ++ lib.optionals withGfxstream (
    [
      aemu
      gfxstream
    ]
    ++ lib.optionals (lib.meta.availableOn stdenv.hostPlatform libdrm) [
      libdrm
    ]
  );

  mesonFlags = [
    (lib.mesonBool "ffi" true)
  ]
  ++ lib.optionals withGfxstream [
    "-Dfeatures=gfxstream"
  ];

  meta = {
    homepage = "https://github.com/magma-gpu/rutabaga_gfx";
    description = "Cross-platform abstraction for GPU and display virtualization";
    license = with lib.licenses; [
      bsd3
      mit
    ];
    maintainers = with lib.maintainers; [ qyliss ];
    platforms = [
      # src/generated/virgl_debug_callback_bindings.rs
      "aarch64-darwin"
      "aarch64-linux"
      "armv5tel-linux"
      "armv6l-linux"
      "armv7a-linux"
      "armv7l-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
})
