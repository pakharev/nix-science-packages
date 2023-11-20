{ lib
, rPackages
, fetchFromGitHub
, fetchzip
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "anndata";
    meta = {
      description = "anndata for R";
      license = lib.licenses.mit;
      homepage = "https://cran.r-project.org/web/packages/anndata/readme/README.html";
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcCRAN") then "srcCRAN" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override {
      owner = "dynverse";
    };
  };
  rDepends = with rPackages; [ 
    assertthat
    Matrix
    reticulate
    R6
  ];
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; rPackages.buildRPackage {
  inherit pname version src meta;

  name = "${pname}-${version}";
  propagatedBuildInputs = rDepends;
  nativeBuildInputs = rDepends;
} 
lib: let
  defaults = info: {
    pname = "anndata";
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}.0.${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "dynverse";
      repo = "anndata";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
    };
  };
in info: lib.pipe info [
  defaults
  devVersion
  fetcher
  meta
] 


