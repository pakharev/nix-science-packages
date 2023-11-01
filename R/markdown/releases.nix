let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-10-19";
    version = "1.11";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-XZxDAUjSACTIVoetfPHfnTrQixw4XsIScup1827jAdY=";
      }
      {
        mirror = "dev";
        hash = "sha256-4HQSkNVe5ZpxQwjh6gE+J/rcZABg3NHfQaGVFhWPfD4=";
      }
    ];
  }
]
