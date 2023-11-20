{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "anndata";
  meta = {
    description = "anndata for R";
    homepage = "https://cran.r-project.org/web/packages/anndata/readme/README.html";
    license = lib.licenses.mit;
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
    owner = "dynverse";
    rev = "refs/tags/${conf.version}";
  });
})

).eval (conf: let
  rDepends = with rPackages; [ 
    assertthat
    Matrix
    reticulate
    R6
  ];
in rPackages.buildRPackage (populateFetchers deps conf // {
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
})) (import ./releases.nix)
