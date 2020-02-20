{
    stdenv,
    makeWrapper,
    libstdcxxHook,
    llvmPackages_9,
    wrapCCWith,
    callPackage
}:
{
  clang = wrapCCWith rec {
      cc = callPackage ./aocc {};

      extraPackages = [
        libstdcxxHook
        llvmPackages_9.compiler-rt
      ];
    };
    
}
