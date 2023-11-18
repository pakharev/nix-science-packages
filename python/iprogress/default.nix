{ lib
, buildPythonPackage
, setuptools-scm
, six
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "IProgress";
    meta = {
      description = "Text progress bar library for Python";
      license = lib.licenses.mit;
      homepage = "https://github.com/aebrahim/IProgress";
      inherit configs;
    };
    fetchers.src = "srcPyPI";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
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
    six
  ];
}) (import ./releases.nix)
