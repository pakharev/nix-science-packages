let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-01-11";
    version = "1.7.12";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-uRLo614wr7qp6Elk3nYF5+glKiYxylDuxRgaRUmojZw=";
      }
    ];
  }
]
