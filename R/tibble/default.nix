{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "tibble";
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
    fansi
    lifecycle
    magrittr
    pillar
    pkgconfig
    rlang
    vctrs
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
