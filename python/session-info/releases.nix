let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2021-05-06";
    version = "1.0.0";
    type = "major";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-PNpeA8ynA/Mq4urb1r2AtsIUQs+2DkEsIcuK1tXLtrc=";
      }
      {
        mirror = "dev";
        hash = "sha256-xGMvUHCB0zI/+er/mlBA7v0oUW69HFZESrxEhok53nA=";
      }
    ];
  }
]
