lib: let
  defaults = info: {
    pname = "triebeard";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
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
  fetcher
  meta
] 
