{ lib
, rPackages
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: let
  depends = with rPackages; [ 
    Rcpp
    triebeard
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
    pname = "urltools";
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}.0.${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    inherit CRAN;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "Ironholds";
      repo = "urltools";
      rev = "${info.version}";
    };
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
  devVersion
  fetcher
  meta
] 
