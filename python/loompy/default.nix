{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, numpy
, scipy
, h5py
, numba
, click
, numpy-groupies
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "loompy";
    meta = {
      description = "Loom is an efficient file format for large omics datasets";
      license = lib.licenses.bsd2;
      homepage = "http://loompy.org/";
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override {
      owner = "linnarsson-lab";
    };
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "pyproject";
  disabled = pythonOlder "3.5";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ 
    setuptools-scm
  ];

  propagatedBuildInputs = [
    numpy
    scipy
    h5py
    numba
    click
    numpy-groupies
  ];
}
