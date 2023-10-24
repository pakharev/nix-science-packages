let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2020-02-06";
    version = "0.4.2";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-yu6soHIJaClWl58iC8aTIPiTv/kXj1LjzeEaoskE+7M=";
      }
    ];
  }
]
