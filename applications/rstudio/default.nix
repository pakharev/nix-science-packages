{ lib
, stdenv
, mkDerivation
, fetchurl
, fetchpatch
, fetchFromGitHub
, callPackage
, makeDesktopItem
, copyDesktopItems
, cmake
, boost
, zlib
, openssl
, R
, qtbase
, qtxmlpatterns
, qtsensors
, qtwebengine
, qtwebchannel
, libuuid
, hunspellDicts
, unzip
, ant
, jdk
, gnumake
, bash
, makeWrapper
, pandoc
, llvmPackages
, yaml-cpp
, soci
, postgresql
, nodejs
, yarn
, fixup_yarn_lock
, qmake
, server ? false # build server version
, sqlite
, pam
, nixosTests
, patchShebangs
}:

let
  pname = "RStudio";
  version = "2023.09-git";
  RSTUDIO_VERSION_MAJOR  = "2023";
  RSTUDIO_VERSION_MINOR  = "09";
  RSTUDIO_VERSION_PATCH  = "";
  RSTUDIO_VERSION_SUFFIX = "";

  RSTUDIO_RELEASE = "desert-sunflower";
  rsconnect_version = "1.1.0";

  src = fetchFromGitHub {
    owner = "rstudio";
    repo = "rstudio";
    rev = "02864b10b141bc6f53e5db5ce05300ea046314c9";
    sha256 = "sha256-A0JRgTZIM91a4JY/BBfq2WopqVkoKPopd3yl1FL91nw=";
    curlOpts = "--netrc-file /etc/nix/netrc";
  };

  # should be on the branch release/rstudio-${RSTUDIO_RELEASE}
  quartoSrc = fetchFromGitHub {
    owner = "quarto-dev";
    repo = "quarto";
    rev = "bc707df49fd6954d899b130def543fd711d206d5";
    sha256 = "sha256-LI0SCOW+D2ewG8yxr5J3GJ4NaIykF50U+9681SC+EKw=";
    curlOpts = "--netrc-file /etc/nix/netrc";
  };

  mathJaxSrc = fetchurl {
    url = "https://s3.amazonaws.com/rstudio-buildtools/mathjax-27.zip";
    sha256 = "sha256-xWy6psTOA8H8uusrXqPDEtL7diajYCVHcMvLiPsgQXY=";
  };

  rsconnectSrc = fetchFromGitHub {
    owner = "rstudio";
    repo = "rsconnect";
    rev = "v${rsconnect_version}";
    sha256 = "sha256-c1fFcN6KAfxXv8bv4WnIqQKg1wcNP2AywhEmIbyzaBA=";
    curlOpts = "--netrc-file /etc/nix/netrc";
  };

  panmirrorCache = (callPackage ./yarndeps.nix {}).offline_cache;

  description = "Set of integrated tools for the R language";
in
(if server then stdenv.mkDerivation else mkDerivation)
  (rec {
    inherit pname version src RSTUDIO_VERSION_MAJOR RSTUDIO_VERSION_MINOR RSTUDIO_VERSION_PATCH RSTUDIO_VERSION_SUFFIX;

    nativeBuildInputs = [
      cmake
      unzip
      bash
      ant
      jdk
      makeWrapper
      pandoc
      nodejs
      yarn
      patchShebangs
    ] ++ lib.optionals (!server) [
      copyDesktopItems
    ];

    buildInputs = [
      boost
      zlib
      openssl
      R
      libuuid
      yaml-cpp
      soci
      postgresql
    ] ++ (if server then [
      sqlite.dev
      pam
    ] else [
      qtbase
      qtxmlpatterns
      qtsensors
      qtwebengine
      qtwebchannel
    ]);

    cmakeFlags = [
      "-DRSTUDIO_TARGET=${if server then "Server" else "Desktop"}"
      "-DCMAKE_BUILD_TYPE=Release"
      "-DRSTUDIO_USE_SYSTEM_SOCI=ON"
      "-DRSTUDIO_USE_SYSTEM_BOOST=ON"
      "-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON"
      "-DQUARTO_ENABLED=FALSE"
      "-DPANDOC_VERSION=${pandoc.version}"
      "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}/lib/rstudio"
    ] ++ lib.optionals (!server) [
      "-DQT_QMAKE_EXECUTABLE=${qmake}/bin/qmake"
    ];

    # Hack RStudio to only use the input R and provided libclang.
    patches = [
      ./r-location.patch
      ./clang-location.patch
      ./soci-lib-location.patch
      ./use-system-node.patch
      ./yarn-set-environment.patch
      ./fix-resources-path.patch
      ./pandoc-nix-path.patch
      ./remove-quarto-from-generator.patch
      ./do-not-install-pandoc.patch
    ];

    postPatch = ''
      substituteInPlace src/cpp/core/r_util/REnvironmentPosix.cpp --replace '@R@' ${R}

      substituteInPlace src/cpp/CMakeLists.txt \
        --replace '@soci@' ${soci}

      substituteInPlace src/gwt/build.xml \
        --replace '@yarn@' ${yarn}

      substituteInPlace src/cpp/core/libclang/LibClang.cpp \
        --replace '@libclang@' ${llvmPackages.libclang.lib} \
        --replace '@libclang.so@' ${llvmPackages.libclang.lib}/lib/libclang.so

      substituteInPlace src/cpp/session/include/session/SessionConstants.hpp \
        --replace '@pandoc@' ${pandoc}/bin/pandoc

      sed '1i#include <set>' -i src/cpp/core/include/core/Thread.hpp
    '';

    hunspellDictionaries = with lib; filter isDerivation (unique (attrValues hunspellDicts));
    # These dicts contain identically-named dict files, so we only keep the
    # -large versions in case of clashes
    largeDicts = with lib; filter (d: hasInfix "-large-wordlist" d.name) hunspellDictionaries;
    otherDicts = with lib; filter
      (d: !(hasAttr "dictFileName" d &&
        elem d.dictFileName (map (d: d.dictFileName) largeDicts)))
      hunspellDictionaries;
    dictionaries = largeDicts ++ otherDicts;

    preConfigure =
    ''
      mkdir dependencies/dictionaries
      for dict in ${builtins.concatStringsSep " " dictionaries}; do
        for i in "$dict/share/hunspell/"*; do
          ln -s $i dependencies/dictionaries/
        done
      done

      unzip -q ${mathJaxSrc} -d dependencies/mathjax-27

      mkdir -p dependencies/pandoc/${pandoc.version}
      cp ${pandoc}/bin/pandoc dependencies/pandoc/${pandoc.version}/pandoc

      cp -r ${rsconnectSrc} dependencies/rsconnect
      ( cd dependencies && ${R}/bin/R CMD build --no-build-vignettes rsconnect )

      export QUARTO=$(readlink -f src/gwt/lib/quarto)
      cp -r ${quartoSrc} $QUARTO
      chmod -R u+w $QUARTO

      ${fixup_yarn_lock}/bin/fixup_yarn_lock $QUARTO/yarn.lock
      HOME=$QUARTO YARN_CACHE_FOLDER=$QUARTO/.yarn_cache yarn --offline config set yarn-offline-mirror ${panmirrorCache}
    '';

    postInstall = ''
      mkdir -p $out/bin $out/share

      ${lib.optionalString (!server) ''
        mkdir -p $out/share/icons/hicolor/48x48/apps
        ln $out/lib/rstudio/rstudio.png $out/share/icons/hicolor/48x48/apps
      ''}

      for f in {${if server
        then "crash-handler-proxy,postback,r-ldpath,rpostback,rserver,rserver-pam,rsession,rstudio-server"
        else "diagnostics,rpostback,rstudio"}}; do
        ln -s $out/lib/rstudio/bin/$f $out/bin
      done

      for f in .gitignore .Rbuildignore LICENSE README; do
        find . -name $f -delete
      done

      rm -r $out/lib/rstudio/{INSTALL,COPYING,NOTICE,README.md,SOURCE,VERSION}
    '';

    meta = with lib; {
      broken = (stdenv.isLinux && stdenv.isAarch64);
      inherit description;
      homepage = "https://www.rstudio.com/";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ ciil cfhammill ];
      mainProgram = "rstudio" + lib.optionalString server "-server";
      platforms = platforms.linux;
    };

    passthru = {
      inherit server;
      tests = { inherit (nixosTests) rstudio-server; };
    };
  } // lib.optionalAttrs (!server) {
    qtWrapperArgs = [
      "--suffix PATH : ${lib.makeBinPath [ gnumake ]}"
    ];

    desktopItems = [
      (makeDesktopItem {
        name = pname;
        exec = "rstudio %F";
        icon = "rstudio";
        desktopName = "RStudio";
        genericName = "IDE";
        comment = description;
        categories = [ "Development" ];
        mimeTypes = [
          "text/x-r-source" "text/x-r" "text/x-R" "text/x-r-doc" "text/x-r-sweave" "text/x-r-markdown"
          "text/x-r-html" "text/x-r-presentation" "application/x-r-data" "application/x-r-project"
          "text/x-r-history" "text/x-r-profile" "text/x-tex" "text/x-markdown" "text/html"
          "text/css" "text/javascript" "text/x-chdr" "text/x-csrc" "text/x-c++hdr" "text/x-c++src"
        ];
      })
    ];
  })
