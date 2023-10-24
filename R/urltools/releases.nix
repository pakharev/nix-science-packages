let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2020-09-30";
    version = "1.7.0";
    type = "dev";
    fetchers = [
      {
        mirror = "dev";
        rev = "ccdd1b4adefe6743fb88f4f2b078811d75de0c9c";
        hash = "sha256-IqQAOXoRPl8BGUMq36XJKFXBqinVZG9XPaPNHXUL924=";
      }
    ];
  }
]
