let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-01-27";
    version = "0.1.9";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-h4eJ4zeWBBcBiygWYtB2nQFn4V/MI/8hj34vNNTdWFk=";
      }
      {
        mirror = "dev";
        hash = "sha256-pxVx4U+zOwmmm2cdrZBJ0A4hVUnN7aznwQCnYiGTBzY=";
      }
    ];
  }
]
