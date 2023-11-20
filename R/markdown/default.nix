{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "markdown";
  meta = {
    description = "Markdown rendering for R";
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
    owner = "rstudio";
    rev = "refs/tags/v${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
    commonmark
    xfun
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
