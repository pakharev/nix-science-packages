{ lib
, buildPythonPackage
, setuptools-scm
, stdlib-list
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "session_info";
    meta = {
      description = "Print version information for loaded modules in the current session, Python, and the OS";
      homepage = "https://gitlab.com/joelostblom/session_info";
      license = lib.licenses.bsd3;
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = (generic "GitLab").override (conf: {
      method = "fetchFromGitLab";
      owner = "joelostblom";
      repo = "session_info";
      rev = "refs/tags/${conf.version}";
    });
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "setuptools";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    stdlib-list
  ];
}) (import ./releases.nix)
