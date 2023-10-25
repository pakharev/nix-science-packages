lib: let
  defaults = info: {
    pname = "mudata";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "scverse";
      repo = "mudata";
      rev = "v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "Multimodal data";
      license = lib.licenses.bsd3;
      homepage = "https://mudata.readthedocs.io/";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
