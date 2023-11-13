lib: let
  defaults = info: {
    pname = "RStudio";
    version = with info; "${RSTUDIO_VERSION_MAJOR}.${RSTUDIO_VERSION_MINOR}.${RSTUDIO_VERSION_PATCH}${RSTUDIO_VERSION_SUFFIX}";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "rstudio";
      repo = "rstudio";
      rev = "v${version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "RNA velocity generalized through dynamical modeling";
      license = lib.licenses.bsd3;
      homepage = "https://scvelo.readthedocs.io/en/stable/";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
