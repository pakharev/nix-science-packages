{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "pagoda2";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

devVersion.R

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = if (conf.sources ? "srcCRAN") then "srcCRAN" else "srcDev";
})

(with commonLocations; resolveLocations {
  inherit CRAN;
  dev = GitHub.override (conf: {
    owner = "kharchenkolab";
    rev = "refs/tags/v${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
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
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
