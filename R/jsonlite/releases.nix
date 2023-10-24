let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-06-05";
    version = "1.8.5";
    type = "minor";
    fetchers = [
      {
        mirror = "dev";
        hash = "sha256-NBpC48bfswvV6dDsyZxE4YN4+VpL1jXkE4tJgULsy+Q=";
      }
    ];
  }
]
