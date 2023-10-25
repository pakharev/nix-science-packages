let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2021-12-27";
    version = "0.1.2";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-2ntpuAQyN8x/fOWRnpzFm9GPxOJwS0PrNOO6T6k3S6s=";
      }
      {
        mirror = "dev";
        hash = "sha256-shvpvkODGCSMrKwA7xbNhwInGvLdpoxsuC+Wh0BQn6Q=";
      }
    ];
  }
]
