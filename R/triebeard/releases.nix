let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-03-04";
    version = "0.4.1";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-jpHQJHc4FY4EMFDceJE5CLrMeKJOrjgFbpom9BnRPOw=";
      }
    ];
  }
]
