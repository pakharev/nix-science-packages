lib: let
  devRepo = {
    site = "github.com";
    owner = "data-apis";
    repo = "array-api-compat";
    method = "fetchFromGitHub";
  };
  defaults = info: {
    pname = "array-api-compat";
    hatch = false;
  } // info;
  meta = info: info // {
    meta = {
      description = "Array API compatibility library";
      homepage = with devRepo; "https://${site}/${owner}/${repo}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ ];
    } // lib.optionalAttrs (info.release != "dev") {
      changelog = with devRepo; "https://${site}/${owner}/${repo}/releases/tag/${info.version}";
    };
  };
  fetcher = info: mirror: if mirror == "pypi" then {
    method = "fetchPypi";
    pname = "array_api_compat";
    inherit (info) version hash;
  } else if mirror == "dev" then {
    inherit (devRepo) method owner repo;
    rev = info.version;
    inherit (info) hash;
  } else {};
  fetchers = info: info // {
    fetchers = map (mirror: fetcher info mirror // info.mirrors.${mirror}) (builtins.attrNames info.mirrors);
  };
  devVersion = info: info // lib.optionalAttrs (info.release == "dev") {
    version = "${info.version}-dev${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  prepare = info: lib.pipe info [
    defaults
    devVersion
    fetchers
    meta
  ];
  
  releases = [
    {
      date = "2023-09-14";
      version = "1.4";
      release = "minor";
      mirrors = {
        pypi = {};
      };
      hash = "sha256-1J8A62a0Ns86YCbW9DwRXT4FijqZNlNrC6wz3UcOi00=";
    }
  ];
  devReleases = map (info: info // { release = "dev"; }) [
  ];
in map prepare (releases ++ devReleases)
