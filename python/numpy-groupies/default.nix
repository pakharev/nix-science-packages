{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, numpy
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "numpy-groupies";
    meta = {
      description = "Optimised tools for group-indexing operations: aggregated sum and more";
      homepage = "https://github.com/ml31415/numpy-groupies";
      license = lib.licenses.bsd2;
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override (conf: {
      owner = "ml31415";
      rev = "refs/tags/v${conf.version}";
    });
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "pyproject";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    numpy
  ];
}
