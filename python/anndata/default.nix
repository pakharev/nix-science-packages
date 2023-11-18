{ lib
, buildPythonPackage
, setuptools-scm
, flit-core
, hatchling
, hatch-vcs
, pythonOlder
, pandas
, numpy
, scipy
, h5py
, natsort
, packaging
, exceptiongroup
, array-api-compat
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "anndata";
    meta = {
      description = "Annotated data";
      license = lib.licenses.bsd3;
      homepage = "https://anndata.readthedocs.io/";
      changelog = "https://anndata.readthedocs.io/en/latest/#latest-additions";
      inherit configs;
    };
    hatch = false;
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override {
      owner = "scverse";
    };
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;

  format = if hatch then "pyproject" else "flit";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = if hatch then [ 
    hatchling hatch-vcs 
  ] else [ 
    setuptools-scm flit-core
  ];

  propagatedBuildInputs = [
    pandas
    numpy
    scipy
    h5py
    natsort
    packaging
  ] ++ lib.optionals hatch [
    array-api-compat
    exceptiongroup
  ];
}) (import ./releases.nix)
