lib: let
  defaults = info: {
    pname = "anndata";
    hatch = false;
    devRepo = {
      site = "github.com";
      owner = "scverse";
      repo = "anndata";
      method = "fetchFromGitHub";
    };
  } // info;
  fetchers = let
    mirrors = {
      pypi = info: {
        method = "fetchPypi";
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
      description = "Annotated data";
      license = lib.licenses.bsd3;
      maintainers = with lib.maintainers; [ ];
      homepage = with info.devRepo; "https://${site}/${owner}/${repo}";
    } // lib.optionalAttrs (info.type != "dev") {
      changelog = with info.devRepo; "https://${site}/${owner}/${repo}/releases/tag/${info.version}";
    };
  };
in info: lib.pipe info [
  defaults
  fetchers
  meta
] 
