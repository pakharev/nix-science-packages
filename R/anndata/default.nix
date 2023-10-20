{ rPackages
, chooseSource
, fetchSource
, source ? (info: info.release)
}: let
  info = chooseSource source ./src.json;
  depends = with rPackages; [ 
    assertthat
    Matrix
    reticulate
    R6
  ];
in rPackages.buildRPackage {
  name = "anndata";
  inherit (info) version;
  src = fetchSource info;
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
