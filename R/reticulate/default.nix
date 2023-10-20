{ rPackages
, fetchSource
, lib
, version ? "git-main-2023-09-21"
}: let
  depends = with rPackages; [
    here
    jsonlite
    Matrix
    png
    rappdirs
    Rcpp
    RcppTOML
    rlang
    withr
  ];
in rPackages.buildRPackage {
  name = "reticulate";
  inherit version;
  src = fetchSource (import ./src.nix).${version};
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
