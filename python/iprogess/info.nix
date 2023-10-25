lib: let
  defaults = info: {
    pname = "IProgress";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
  };
  meta = info: info // {
    meta = {
      description = "Text progress bar library for Python";
      license = lib.licenses.mit;
      homepage = "https://github.com/aebrahim/IProgress";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
