let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2022-03-05";
    version = "3.0.7";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-tc33tUc0xr7ToYHRGUevcK8sbg3K3AL9Docd8jL6qPQ=";
      }
      {
        mirror = "dev";
        hash = "sha256-YKWKiPB4aNx9mOh84y7QrtpB7KQ1LyYL3McPH7YXvHY=";
      }
    ];
  }
]
