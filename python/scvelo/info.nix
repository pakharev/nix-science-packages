lib: let
  defaults = info: {
    pname = "scvelo";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "theislab";
      repo = "scvelo";
      rev = "v${info.version}";
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
