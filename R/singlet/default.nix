{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "singlet";
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
    owner = "zdebruine";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
    Seurat
    dplyr
    limma
    fgsea
    msigdbr
    RcppML
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
