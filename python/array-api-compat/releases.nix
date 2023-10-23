let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-09-14";
    version = "1.4";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-1J8A62a0Ns86YCbW9DwRXT4FijqZNlNrC6wz3UcOi00=";
      }
      {
        mirror = "dev";
	hash = "sha256-rW5Pql+1b012OFGlfY8V259d2ka1WvekXFQQRu0dvMA=";
      }
    ];
  }
]
