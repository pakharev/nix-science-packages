let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-08-30";
    version = "2.0.3";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "d93914af95d84297f5c7f0199639bc72440f0a33";
        hash = "sha256-Zv5LQWrWSU9fcr+V3+vtHHe6I7ytHzdNNoHq4VpRBBE=";
      }
    ];
  }
]
