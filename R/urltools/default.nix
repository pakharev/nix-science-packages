{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "urltools";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = if (config.sources ? "srcCRAN") then "srcCRAN" else "srcDev";
})

devVersion.R

(with commonLocations; resolveLocations {
  inherit CRAN;
  dev = GitHub.override (conf: {
    owner = "Ironholds";
    rev = "refs/tags/${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
    Rcpp
    triebeard
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
