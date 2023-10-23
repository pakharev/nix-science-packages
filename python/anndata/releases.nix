let
  mapFetchers = release: map (fetcher:
    (builtins.removeAttrs release [ "fetchers" ]) // { inherit fetcher; }
  ) release.fetchers;
in builtins.concatMap mapFetchers [
  ### common releases
  {
    date = "2023-10-06";
    version = "0.10.0";
    type = "major";
    hatch = true;
    fetchers = [
      {
        mirror = "PyPI";
	hash = "sha256-++UByX3yMuCNCh9Dj2Y4crZQ+w1RUNK7Byz+UxEPRoA=";
      }
      {
        mirror = "dev";
	hash = "sha256-rW5Pql+1b012OFGlfY8V259d2ka1WvekXFQQRu0dvMA=";
      }
    ];
  }
  {
    date = "2023-08-25";
    version = "0.9.2";
    type = "minor";
    fetchers = [
      {
        mirror = "PyPI";
	hash = "sha256-5bg4PQlyOvZ0yuetDC71PrH4xzlJt/TBgqbjD0IZYyc=";
      }
      {
        mirror = "dev";
	hash = "sha256-X6gHlmiTZt+cxGacCASPGaW9BlsMrfR1yw6mwgF5lvs=";
      }
    ];
  }
  ### dev releases
  {
    date = "2023-10-04";
    version = "0.10";
    type = "dev";
    hatch = true;
    fetchers = [
      {
        mirror = "dev";
        rev = "afc593058e343bccd13ca2c6164a796333670f16";
        hash = "sha256-N9oh+I9thZj0OvWOS2tNETHKpjGawfKLoP9mpWX5gVw=";
      }
    ];
  }
]
