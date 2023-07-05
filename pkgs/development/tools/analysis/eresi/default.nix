{ stdenv, lib, fetchFromGitHub, which, openssl, readline, fetchpatch }:

stdenv.mkDerivation rec {
  pname = "eresi";
  version = "0.83-a3-phoenix";

  src = fetchFromGitHub {
    owner = "thorkill";
    repo = "eresi";
    rev = version;
    sha256 = "0a5a7mh2zw9lcdrl8n1mqccrc0xcgj7743l7l4kslkh722fxv625";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/thorkill/eresi/commit/a79406344cc21d594d27fa5ec5922abe9f7475e7.patch";
      sha256 = "1mjjc6hj7r06iarvai7prcdvjk9g0k5vwrmkwcm7b8ivd5xzxp2z";
    })

    # Pull patch pending upstream inclusion for -fno-common toolchains:
    #   https://github.com/thorkill/eresi/pull/166
    (fetchpatch {
      url = "https://github.com/thorkill/eresi/commit/bc5b9a75c326f277e5f89e01a3b8f7f0519a99f6.patch";
      sha256 = "0lqwrnkkhhd3vi1r8ngvziyqkk09h98h93rrs3ndqi048a898ys1";
    })
  ];

  postPatch = ''
    # Two occurences of fprintf() with only two arguments, which should really
    # be fputs().
    #
    # Upstream pull request: https://github.com/thorkill/eresi/pull/162
    #
    sed -i -e 's/fprintf(\(stderr\), *\([a-z0-9]\+\))/fputs(\2, \1)/g' \
      libe2dbg/common/common.c libe2dbg/user/threads.c

    # We need to patch out a few ifs here, because it tries to create a series
    # of configuration files in ~/.something. However, our builds are sandboxed
    # and also don't contain a valid home, so let's NOP it out :-)
    #
    # The second fix we need to make is that we need to pretend being Gentoo
    # because otherwise the build process tries to link against libtermcap,
    # which I think is solely for historic reasons (nowadays Terminfo should
    # have largely superseded it).
    sed -i -e '/^if \[ ! -e/c if false; then' \
           -e 's/^GENTOO=.*/GENTOO=1/' configure
  '';

  configureFlags = [
    (if stdenv.is64bit then "--enable-32-64" else "--enable-32")
    "--enable-readline"
  ];

  # The configure script is not generated by autoconf but is hand-rolled, so it
  # has --enable-static but no --disabled-static and also doesn't support the
  # equals sign in --prefix.
  prefixKey = "--prefix ";
  dontDisableStatic = true;

  nativeBuildInputs = [ which ];
  buildInputs = [ openssl readline ];
  enableParallelBuilding = true;
  # ln: failed to create symbolic link '...-eresi-0.83-a3-phoenix//bin/elfsh': No such file or directory
  # make: *** [Makefile:108: install64] Error 1
  enableParallelInstalling = false;

  installTargets = lib.singleton "install"
                ++ lib.optional stdenv.is64bit "install64";

  meta = {
    description = "The ERESI Reverse Engineering Software Interface";
    license = lib.licenses.gpl2Only;
    homepage = "https://github.com/thorkill/eresi"; # Formerly http://www.eresi-project.org/
    platforms = lib.platforms.linux;
  };
}
