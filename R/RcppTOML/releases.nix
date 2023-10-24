let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-05-26";
    version = "0.4";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "415aa799d172113aa8cec7910810e048bfed5da6";
        hash = "sha256-FSCAYvL1jP/CPbPpP6HPKENwg7HdjBZ7US2RG5x+aM0=";
      }
    ];
  }
]
