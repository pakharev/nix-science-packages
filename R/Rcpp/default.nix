{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "Rcpp";
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
    owner = "RcppCore";
    rev = "refs/tags/v${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
