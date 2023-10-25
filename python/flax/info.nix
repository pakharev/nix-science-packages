lib: let
  defaults = info: {
    pname = "flax";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    #inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "google";
      repo = info.pname;
      rev = "refs/tags/v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "Neural network library for JAX";
      license = lib.licenses.asl20;
      homepage = "https://github.com/google/flax";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
