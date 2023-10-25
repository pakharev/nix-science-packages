lib: let
  defaults = info: {
    pname = "session_info";
  } // info;
  fetcher = with lib.mirrors; resolveFetcher {
    inherit PyPI;
    dev = info: generic "gitlab" info // {
      method = "fetchFromGitLab";
      owner = "joelostblom";
      repo = "session_info";
      rev = info.version;
    };
  };
  meta = info: info // {
    meta = {
      description = "Print version information for loaded modules in the current session, Python, and the OS";
      homepage = "https://gitlab.com/joelostblom/session_info";
      license = lib.licenses.bsd3;
    };
  };
in info: lib.pipe info [
  defaults
  fetcher
  meta
] 
