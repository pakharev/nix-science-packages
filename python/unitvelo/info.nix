lib: let
  defaults = info: {
    pname = "unitvelo";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "StatBiomed";
      repo = "UniTVelo";
      rev = "v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "UniTVelo for RNA Velocity Analysis";
      license = lib.licenses.bsd3;
      homepage = "https://unitvelo.readthedocs.io/en/latest/";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
