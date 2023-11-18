{ lib
, buildPythonPackage
, setuptools-scm
, poetry-core
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "get-annotations";
    meta = {
      description = "A backport of Python 3.10 get_annotations() function";
      homepage = "https://github.com/shawwn/get-annotations";
      license = lib.licenses.mit;
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override {
      owner = "shawwn";
    };
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "pyproject";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm poetry-core
  ];
}) (import ./releases.nix)
