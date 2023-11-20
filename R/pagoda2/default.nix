{ lib
, rPackages
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: let
  depends = with rPackages; [ 
    dendsort
    drat
    fastcluster
    igraph
    irlba
    magrittr
    MASS
    Matrix
    mgcv
    N2R
    plyr
    R_utils
    R6
    Rcpp
    RcppArmadillo
    RcppEigen
    RcppProgress
    rjson
    rlang
    RMTstat
    Rook
    Rtsne
    sccore
    urltools
  ];
in with info; rPackages.buildRPackage {
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;

  inherit version;
  name = "${pname}-${version}";
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
} 
lib: let
  defaults = info: {
    pname = "pagoda2";
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}.0.${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "kharchenkolab";
      repo = "pagoda2";
      rev = "v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "";
      #license = ;
      homepage = "";
    };
  };
in info: lib.pipe info [
  defaults
  devVersion
  fetcher
  meta
] 
