let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-08-31";
    version = "1.0.11.2";
    type = "patch";
    fetchers = [
      {
        mirror = "dev";
	rev = "62bb38178399b061d34b8f838d45a4730cb03fbb";
        hash = "sha256-i9ODeC3k9a3jxYIvkPbTwZJTlEWhNAiRWG6Lgk9oXLs=";
      }
    ];
  }
]
