let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-04-19";
    version = "2.5.0";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "e97cca79f5b9eef029330ca45b765cdc9e249f29";
        hash = "sha256-e+JBnomBtfPMQLOaSrC1zL7ZolEeFWdYD35ckFYBExE=";
      }
    ];
  }
]
