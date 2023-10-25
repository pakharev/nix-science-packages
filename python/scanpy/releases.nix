let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-09-08";
    version = "1.9.5";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-HZD5XNXhA8ngzEH9hMHy2B2G1jN8vilDFleO0HHTnYI=";
      }
      {
        mirror = "dev";
        hash = "sha256-Zk4nVMhghS2HdTAYU7r5VWnaB4qU7f/LQASWCcD1HXg=";
      }
    ];
  }
]
