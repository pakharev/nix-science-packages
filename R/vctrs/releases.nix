let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-10-12";
    version = "0.6.4";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-rKQxgaOIWoFBNgo9dP8jsELkVfOhSU/EyRymdfY30H4=";
      }
      {
        mirror = "dev";
        hash = "sha256-pb32DVep/wPdcy+55wImcjHo9RWVhuvkItO4FATt5mU=";
      }
    ];
  }
  {
    date = "2023-06-15";
    version = "0.6.3";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-WZy6JcNdcjoZIeSokxmhEU2lNrGR5ndjmsr57+b4v20=";
      }
    ];
  }
]
