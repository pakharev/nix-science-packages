{ lib
, rPackages
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: let
  depends = with rPackages; [ 
    Rcpp
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
    pname = "triebeard";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
  };
  meta = info: info // {
    meta = {
      description = "";
      #license = ;
      homepage = "";
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
