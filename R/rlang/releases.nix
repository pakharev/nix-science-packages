let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-06-07";
    version = "1.1.1";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "c55f6027928d3104ed449e591e8a225fcaf55e13";
        hash = "sha256-NH5Qf/VZ8EOtPU4eucuwHESESi4d8suKk6T8++0ebDM=";
      }
    ];
  }
]
