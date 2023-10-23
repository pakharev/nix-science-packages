lib: let
  defaults = info: {
    pname = "anndata";
    hatch = false;
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}-dev${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "scverse";
      repo = "anndata";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "Annotated data";
      license = lib.licenses.bsd3;
      maintainers = with lib.maintainers; [ ];
      homepage = "https://anndata.readthedocs.io/";
    } // lib.optionalAttrs (info.type != "dev") {
      changelog = "https://anndata.readthedocs.io/en/latest/#latest-additions";
    };
  };
in info: lib.pipe info [
  defaults
  devVersion
  fetcher
  meta
] 
