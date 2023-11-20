{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "gratia";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = if (conf.sources ? "srcCRAN") then "srcCRAN" else "srcDev";
})

devVersion.R

(with commonLocations; resolveLocations {
  inherit CRAN;
  dev = GitHub.override (conf: {
    owner = "gavinsimpson";
    rev = "refs/tags/v${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
    mgcv
    ggplot2
    tibble
    dplyr
    tidyr
    rlang
    patchwork
    vctrs
    mvnfast
    purrr
    stringr
    tidyselect
    lifecycle
    pillar
    cli
    nlme
    ggokabeito
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
