lib: let
  defaults = info: {
    pname = "scanpy";
    hatch = false;
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "scverse";
      repo = "scanpy";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "Single-Cell Analysis in Python";
      license = lib.licenses.bsd3;
      homepage = "https://scanpy.readthedocs.io/en/stable/";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
