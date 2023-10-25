let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-09-13";
    version = "0.7.4";
    type = "minor";
    fetchers = [
      {
        mirror = "dev";
        hash = "sha256-i48omag/1Si3mCCGfsUD9qeejyeCLWzvvwKJqH8vm8k=";
      }
    ];
  }
]
