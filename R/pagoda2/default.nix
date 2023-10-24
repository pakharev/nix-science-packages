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
