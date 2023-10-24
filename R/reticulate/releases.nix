let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-09-21";
    version = "1.33";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "d5b014b2ba197e5de0c906fa7c31d146c427bbb6";
        hash = "sha256-mvRNibymWn139jiRp0CbSij4rILSzNbX88AlXw/k/PM=";
      }
    ];
  }
]
