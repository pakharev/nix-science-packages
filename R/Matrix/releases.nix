let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-09-18";
    version = "1.6-1.1";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-/DCiOU4aLA+k9Msj3mTegy8e8k6bTnma6RGLU493K8c=";
      }
    ];
  }
]
