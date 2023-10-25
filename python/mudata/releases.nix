let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-06-06";
    version = "0.2.3";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-RSiKwVC/xZjWist8LBxDw4xcOVIhB+BPfvvzNgx/IDU=";
      }
      {
        mirror = "dev";
        hash = "sha256-mss36qKxveLdIcyYV+yWVLwzd3jcot0gyAmVU3CYAAo=";
      }
    ];
  }
]
