let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2016-06-22";
    version = "0.4";
    type = "major";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-Vca86K1EAYiTMPsRJcC/eBC/v+AQXAWPhhrpHpYtUes=";
      }
    ];
  }
]
