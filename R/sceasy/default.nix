{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "sceasy";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

devVersion.R

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = "srcDev";
})

(with commonLocations; resolveLocations {
  dev = GitHub.override (conf: {
    owner = "cellgeni";
    rev = "refs/tags/v${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
    reticulate
    anndata
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
