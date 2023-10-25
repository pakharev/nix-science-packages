let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-10-13";
    version = "1.0.4";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-p4AiHqHGIBtSeKjFPfGkZ5xkIaog/b2tnWvt1iI7IkA=";
      }
      {
        mirror = "dev";
        hash = "sha256-oLNKsnOzQjKfxy0DV79hsGZdrW5BZrY+05u4o1BP2JI=";
      }
    ];
  }
]
