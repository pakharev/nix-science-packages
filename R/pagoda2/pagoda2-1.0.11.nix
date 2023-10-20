{ rPackages
, fetchFromGitHub
, lib
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
in rPackages.buildRPackage {
  name = "pagoda2";
  version = "1.0.11";
  src = fetchFromGitHub {
    owner = "kharchenkolab";
    repo = "pagoda2";
    rev = "v1.0.11";
    sha256 = "sha256-bmyH0H4GuKJPo8HR+hEoSis6H6lQQTyUTBFsrYHAx8s=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
