# DO NOT EDIT! This file is generated automatically.
# Command: ./maintainers/scripts/fetch-kde-qt.sh pkgs/development/libraries/qt-5/5.13
{ fetchurl, mirror }:

{
  qt3d = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qt3d-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-a8EIbYxqNqgN+pObXss3K+jJE6geKYbYQwIBLq/cS2M=";
      name = "qt3d-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtactiveqt = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtactiveqt-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-a8EIbYxqNqgN+pObXss3K+jJE6geKYbYQwIBLq/cS2M=";
      name = "qtactiveqt-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtandroidextras = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}//archive/qt/5.13/5.13.0/submodules/qtandroidextras-everywhere-src-5.13.0.tar.xz";
      sha256 = "0blapv4jd80wcvzp96zxlrsyca7lwax17y6yij1d14a51353hrnc";
      name = "qtandroidextras-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtbase = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtbase-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-/2lks7UozTsdIbzzRwAG6OXL5pWRkj+YKHHYhuoEiP4=";
      name = "qtbase-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtcanvas3d = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtcanvas3d-everywhere-src-5.13.0.tar.xz";
      sha256 = "0pbxw89m2s19yk2985c49msd7s1mapydka9b7nzg9phs9nrzvf1m";
      name = "qtcanvas3d-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtcharts = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtcharts-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-BOOB7Ch+3yMFg+sy+83kC85iEZ0+q74pePTOg2bjayc=";
      name = "qtcharts-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtconnectivity = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtconnectivity-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-ZPrQaSxjnSUpXMhfElJvP+Lq61G89H2FYa0A3VetUFM=";
      name = "qtconnectivity-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtdatavis3d = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtdatavis3d-everywhere-src-5.13.0.tar.xz";
      sha256 = "1ximhph17kkh40v2ksk51lq21mbjs2ajyf5l32ckhc7n7bmaryb6";
      name = "qtdatavis3d-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtdeclarative = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtdeclarative-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-ueh4Cu8K9KYOZNzEBb31wDoEso47lNXC5p0ABttWa6k=";
      name = "qtdeclarative-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtdoc = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtdoc-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-flICuD6RVVx/CEKRgzK01iOCgAK0b96TAUoyxr7qgQY=";
      name = "qtdoc-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtgamepad = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtgamepad-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-a8EIbYxqNqgN+pObXss3K+jJE6geKYbYQwIBLq/cS2M=";
      name = "qtgamepad-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtgraphicaleffects = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtgraphicaleffects-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-M7+S1lYNTXuH8+md+svJyvx+pe89QPAMw3d6AFJR0P8=";
      name = "qtgraphicaleffects-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtimageformats = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtimageformats-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-kctjjl+FaswXq1ouGgUtyRuxryvb19mbpqikj0oV9Jk=";
      name = "qtimageformats-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtlocation = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtlocation-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-IFpH0lmEGzh5xZ0wVNixCY07DntFxkrTJ9rt77RCFBQ=";
      name = "qtlocation-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtmacextras = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtmacextras-everywhere-src-5.13.0.tar.xz";
      sha256 = "0mh9p3f1f22pj4i8yxnn56amy53dapmcikza04ll4fvx5hy340v8";
      name = "qtmacextras-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtmultimedia = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtmultimedia-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-UHYhnSdwg9JTXl9znQZ4Or4uBZ6dP9n5JKH6eXCUbXI=";
      name = "qtmultimedia-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtnetworkauth = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtnetworkauth-everywhere-src-5.13.0.tar.xz";
      sha256 = "12n3xqlskrk2mbcgz5p613sx219j6rmpq8yn7p97xdv7li61gzl2";
      name = "qtnetworkauth-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtpurchasing = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtpurchasing-everywhere-src-5.13.0.tar.xz";
      sha256 = "1azdg03vxyk140i9z93x0zzlazbmd3qrqxgwk747jsd1ibns9ddy";
      name = "qtpurchasing-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtquickcontrols = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtquickcontrols-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-pcbUDgQyJGEp0/NQqapBmQHdc/Lk+K9u+3o+huV64Wc=";
      name = "qtquickcontrols-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtquickcontrols2 = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtquickcontrols2-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-pct+bWgoUgO/sa7odVEiiHn6nZPYe+XIurOOWnnckW0=";
      name = "qtquickcontrols2-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtremoteobjects = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtremoteobjects-everywhere-src-5.13.0.tar.xz";
      sha256 = "147p0xdi22xz2d3501ig78bs97gbyz8ccyhn6dhbw2yalx33gma6";
      name = "qtremoteobjects-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtscript = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtscript-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-IyPrk6IVuDfY0nb38159+2oouVLYtR+5LGBhmBOjeoA=";
      name = "qtscript-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtscxml = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtscxml-everywhere-src-5.13.0.tar.xz";
      sha256 = "057zchhm1s5ly2a685y4105pgmzgqp1jkkf9w0ca8xd05z4clb4r";
      name = "qtscxml-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtsensors = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtsensors-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-H65Sg2x4ap/VDp4dWQOEua6kefRWnjP8LWlTa74s3kg=";
      name = "qtsensors-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtserialbus = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtserialbus-everywhere-src-5.13.0.tar.xz";
      sha256 = "0zd0crs2nrsvncj070fl05g0nm3j5bf16g54c7m9603b6q7bryrx";
      name = "qtserialbus-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtserialport = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtserialport-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-L1gwl4nh1rOiZTki+TJwPP/92uoGv/Y6VSkAvWO+uYU=";
      name = "qtserialport-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtspeech = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtspeech-everywhere-src-5.13.0.tar.xz";
      sha256 = "11fycm604r1xswb9dg1g568jxd68zd9m2dzfy4qda6sr4mdaj6jg";
      name = "qtspeech-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtsvg = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtsvg-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-D1aOINE0GMbY45XbLOTS1wbT+0cM1mWFPjY3op/eDq8=";
      name = "qtsvg-everywhere-src-5.13.0.tar.xz";
    };
  };
  qttools = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qttools-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-p4h6YY3GQ0wlZ1IZkMKnynLKaoN5wdk8WqbBeY16CBk=";
      name = "qttools-everywhere-src-5.13.0.tar.xz";
    };
  };
  qttranslations = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qttranslations-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-L4+zssYvzxqs0LMkMrlgqDVGOEaIwOp4UU5M9PL5TCg=";
      name = "qttranslations-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtvirtualkeyboard = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtvirtualkeyboard-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-kUg/63nGSOyIIKI47ioSzxqhF+jzpbBtBpRQ4MmtQuk=";
      name = "qtvirtualkeyboard-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwayland = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwayland-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-tnptgRlii8ozAb0DmSiA2wfWHUBVNAZ8nNKlmGlafPM=";
      name = "qtwayland-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwebchannel = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwebchannel-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-f2JgxzvKloURqy+s+7FLTYzHqcWy0PkhHnOQ7Y+1K5o=";
      name = "qtwebchannel-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwebengine = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwebengine-everywhere-src-5.13.0.tar.xz";
      sha256 = "16zbyfc7qy9f20anfrdi25f6nf1j7zw8kps60mqb18nfjw411d50";
      name = "qtwebengine-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwebglplugin = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwebglplugin-everywhere-src-5.13.0.tar.xz";
      sha256 = "0nhim67rl9dbshnarismnd54qzks8v14a08h8qi7x0dm9bj9ij7q";
      name = "qtwebglplugin-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwebsockets = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwebsockets-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-+UHdRPbhYEGiVyPBtwzp4okQxjBQnaAETsuf3aKKbjQ=";
      name = "qtwebsockets-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwebview = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwebview-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-CQ2i9Bs+pA5z06fX2HNJK7kRo0kjdrtE2u6Re0WVNak=";
      name = "qtwebview-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtwinextras = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtwinextras-everywhere-src-5.13.0.tar.xz";
      sha256 = "1x5k0z0p94zppqsw2fz8ki9v5abf0crzva16wllznn89ylqjyn0j";
      name = "qtwinextras-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtx11extras = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtx11extras-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-8z/hzyJYvJchcfcjxvNyCNpH9XiwmHb+pHx7pVio8dY=";
      name = "qtx11extras-everywhere-src-5.13.0.tar.xz";
    };
  };
  qtxmlpatterns = {
    version = "5.13.0";
    src = fetchurl {
      url = "${mirror}/archive/qt/5.13/5.13.0/submodules/qtxmlpatterns-everywhere-src-5.13.0.tar.xz";
      sha256 = "sha256-dRhv8HXZo70wzuFFuta8adSRteVVsEjRETZyfwUNcxk=";
      name = "qtxmlpatterns-everywhere-src-5.13.0.tar.xz";
    };
  };
}
