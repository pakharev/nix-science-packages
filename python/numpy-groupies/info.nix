lib: let
  defaults = info: {
    pname = "numpy-groupies";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "ml31415";
      repo = "numpy-groupies";
      rev = "v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "Optimised tools for group-indexing operations: aggregated sum and more";
      homepage = "https://github.com/ml31415/numpy-groupies";
      license = lib.licenses.bsd2;
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
