let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### dev releases
  {
    date = "2023-08-30";
    version = "0.2.dev20230830";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "a1a1b83c0ae6d181d0e5f3f07f81701f032ad45a";
        hash = "sha256-FA1Te1GhLdszyEbsADuE7j45Qt1t3txifRgP9UMAfDI=";
      }
    ];
  }
]
