{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchPypi
, setuptools-scm
, pythonOlder
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "array-api-compat";
    meta = {
      description = "Array API compatibility library";
      homepage = "https://github.com/data-apis/array-api-compat/";
      license = lib.licenses.mit;
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    PyPI = PyPI.override {
      pname = "array_api_compat";
    };
    dev = GitHub.override {
      owner = "data-apis";
    };
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "setuptools";
  disabled = pythonOlder "3.7";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  # requires too much
  doCheck = false;
}
