lib: let
  defaults = info: {
    pname = "array-api-compat";
    devRepo = {
      site = "github.com";
      owner = "data-apis";
      repo = "array-api-compat";
      method = "fetchFromGitHub";
    };
  } // info;
  fetchers = let
    mirrors = {
      pypi = info: {
        method = "fetchPypi";
        pname = "array_api_compat";
        inherit (info) pname version;
      };
      dev = info: {
        inherit (info.devRepo) method owner repo;
        rev = info.version;
      };
    };
  in info: info // {
    fetcher = mirrors.${info.mirror} info // info.fetcher;
  };
  meta = info: info // {
    meta = {
      description = "Array API compatibility library";
      homepage = with devRepo; "https://${site}/${owner}/${repo}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ ];
    } // lib.optionalAttrs (info.type != "dev") {
      changelog = with info.devRepo; "https://${site}/${owner}/${repo}/releases/tag/${info.version}";
    };
  };
in info: lib.pipe info [
  defaults
  fetchers
  meta
] 
