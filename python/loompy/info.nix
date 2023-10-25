lib: let
  defaults = info: {
    pname = "loompy";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "linnarsson-lab";
      repo = "loompy";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "Loom is an efficient file format for large omics datasets";
      license = lib.licenses.bsd2;
      homepage = "http://loompy.org/";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
