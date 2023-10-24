let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2021-01-31";
    version = "0.3.3";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-7BB/3CAWFrKOLymGpy7LbuiJl+Exm/VWIn4EaNxxAQ8=";
      }
      {
        mirror = "dev";
        hash = "sha256-k/lHm5Hnon8xo7ZDwQm4uCqPHNbCtHxTc2uHwuJCZMU="; 
      }
    ];
  }
]
