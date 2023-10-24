let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-09-19";
    version = "2.5.1";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "687f3a39c603622aea3bc54c3decbb379972b0f3";
        hash = "sha256-i0UvuMrIO+ia0cEHnUO0GZbKHDTpmvSSM2+owx0Y4Y8=";
      }
    ];
  }
]
