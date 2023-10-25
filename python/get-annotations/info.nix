lib: let
  defaults = info: {
    pname = "get-annotations";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "github" info // {
      method = "fetchFromGitHub";
      owner = "shawwn";
      repo = "get-annotations";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "A backport of Python 3.10 get_annotations() function";
      homepage = "https://github.com/shawwn/get-annotations";
      license = lib.licenses.mit;
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
