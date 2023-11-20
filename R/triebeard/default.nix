{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "triebeard";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

devVersion.R

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = "srcCRAN";
})

(with commonLocations; resolveLocations {
  inherit CRAN;
})

).eval (conf: let
  rDepends = with rPackages; [ 
    Rcpp
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
