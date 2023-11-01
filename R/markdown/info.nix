lib: let
  defaults = info: {
    pname = "markdown";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "rstudio";
      repo = "markdown";
      rev = "v${info.version}";
    };
  };
  meta = info: info // {
    meta = {
      description = "Markdown rendering for R";
      #license = ;
      homepage = "";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
