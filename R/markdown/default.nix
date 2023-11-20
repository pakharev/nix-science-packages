{ lib
, rPackages
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: let
  depends = with rPackages; [ 
    commonmark
    xfun
  ];
in with info; rPackages.buildRPackage {
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;

  inherit version;
  name = "${pname}-${version}";
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
} 
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
