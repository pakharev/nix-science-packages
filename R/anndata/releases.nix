let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2022-08-24";
    version = "0.7.5.4";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-WTy7O4gLC3N9c6NXsTyVEyYj0sotAU6o+MKwlodGWxI=";
      }
      {
        mirror = "dev";
        hash = "sha256-sG9FCapTFweGxxErlitYC9gqI6/c6ImNjxGpcIie/OU=";
      }
    ];
  }
]
