let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  {
    date = "2023-10-03";
    version = "0.10.2";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
        hash = "sha256-+SDE3tiZ9ZddlPxj1jTnyJYiBWu6uMyYpE1DIKCuihI=";
      }
      {
        mirror = "dev";
        hash = "sha256-sMjXoP2pOlC8EJHRcjDldSMrrISVsnK6ExuhruEyYOU=";
      }
    ];
  }
]
