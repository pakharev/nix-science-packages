lib: let
  defaults = info: {
    pname = "reticulate";
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}.0.${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "rstudio";
      repo = "reticulate";
      rev = "v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "";
      #license = ;
      #maintainers = with lib.maintainers; [ ];
      homepage = "";
    };
  };
in info: lib.pipe info [
  defaults
  devVersion
  fetcher
  meta
] 