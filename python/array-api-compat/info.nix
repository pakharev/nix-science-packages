lib: let
  defaults = info: {
    pname = "array-api-compat";
  } // info;
  devVersion = info: info // lib.optionalAttrs (info.type == "dev") {
    version = "${info.version}-dev${builtins.replaceStrings [ "-" ] [ "" ] info.date}";
  };
  fetcher = with lib.mirrors; resolveFetcher {
    PyPI = info: {
      method = "fetchPypi";
      pname = "array_api_compat";
      inherit (info) version;
    };
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "data-apis";
      repo = "array-api-compat";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "Array API compatibility library";
      homepage = with info.devRepo; "https://${site}/${owner}/${repo}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ ];
    } // lib.optionalAttrs (info.type != "dev") {
      changelog = with info.devRepo; "https://${site}/${owner}/${repo}/releases/tag/${info.version}";
    };
  };
in info: lib.pipe info [
  defaults
  devVersion
  fetcher
  meta
] 
