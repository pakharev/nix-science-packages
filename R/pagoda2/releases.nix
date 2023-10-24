let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-08-08";
    version = "1.0.11";
    type = "minor";
    fetchers = [
      {
        mirror = "CRAN";
        hash = "sha256-XYWxbw7I3vLscKOXUVSlFdxkhb1R7m2m/qNXwWgcMLw=";
      }
      {
        mirror = "dev";
        hash = "sha256-bmyH0H4GuKJPo8HR+hEoSis6H6lQQTyUTBFsrYHAx8s=";
      }
    ];
  }
]
