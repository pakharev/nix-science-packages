{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "pillar";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = "srcCRAN";
})

devVersion.R

(with commonLocations; resolveLocations {
  inherit CRAN;
})

).eval (conf: let
  rDepends = with rPackages; [ 
    cli
    glue
    lifecycle
    rlang
    fansi
    utf8
    vctrs
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
