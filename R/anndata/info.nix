lib: let
  defaults = info: {
    pname = "anndata";
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}.0.${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "dynverse";
      repo = "anndata";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "anndata for R";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ ];
      homepage = "https://cran.r-project.org/web/packages/anndata/readme/README.html";
    };
  };
in info: lib.pipe info [
  defaults
  devVersion
  fetcher
  meta
] 
