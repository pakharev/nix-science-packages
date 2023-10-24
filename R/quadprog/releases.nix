let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2019-11-20";
    version = "1.5-8";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-zOkrH9Q4bm+iEfJ+n8FCHgVfzx0QBwIHoxzFP1R9tdM=";
      }
    ];
  }
]
