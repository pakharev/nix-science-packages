let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-03-23";
    version = "1.0.1.9005";
    type = "patch";
    fetchers = [
      {
        mirror = "dev";
        rev = "2c187aefed3a9a5277f2f03c5d41a38dbf4d59d7";
        hash = "sha256-nCtEaWJ+JAYIZ5QFeCt1hCsP/6T8gBxGLmNS/6L7qgQ=";
      }
    ];
  }
]
