(builtins.concatMap (r: map (m: r // { 
  mirror = m;
  fetcher = r.mirrors.${m};
}) (builtins.attrNames r.mirrors)) [
  {
    date = "2023-10-06";
    version = "0.10.0";
    type = "major";
    hatch = true;
    mirrors = {
      pypi = {
      };
      dev = {
        hash = "sha256-++UByX3yMuCNCh9Dj2Y4crZQ+w1RUNK7Byz+UxEPRoA=";
      };
    };
  }
  {
    date = "2023-08-25";
    version = "0.9.2";
    type = "minor";
    mirrors = {
      pypi = {
      };
      dev = {
        hash = "sha256-5bg4PQlyOvZ0yuetDC71PrH4xzlJt/TBgqbjD0IZYyc=";
      };
    };
  }
]) ++ (map (r: r // { 
  type = "dev"; 
  mirror = "dev";
  version = "${r.version}-dev${builtins.replaceStrings [ "-" ] [ "" ] r.date}";
}) [
  {
    date = "2023-10-04";
    version = "0.10";
    hatch = true;
    fetcher = {
      rev = "afc593058e343bccd13ca2c6164a796333670f16";
      hash = "sha256-N9oh+I9thZj0OvWOS2tNETHKpjGawfKLoP9mpWX5gVw=";
    };
  }
])
