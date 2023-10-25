lib: let
  defaults = info: {
    pname = "scvi-tools";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    PyPI = info: {
      method = "fetchPypi";
      pname = "scvi_tools";
      inherit (info) version;
    };
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "scverse";
      repo = "scvi-tools";
      rev = if info.version < "1." then
        "v${info.version}"
      else
        info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "Probabilistic models for single-cell omics data";
      license = lib.licenses.bsd3;
      homepage = "https://scvi-tools.org/";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
