{ lib
, buildPythonPackage
, pythonOlder
, setuptools-scm
, flit-core
, hatchling
, hatch-vcs
, anndata
, numpy
, matplotlib
, pandas
, scipy
, seaborn
, h5py
, tqdm
, scikit-learn
, statsmodels
, patsy
, networkx
, natsort
, joblib
, numba
, umap-learn
, packaging
, session-info
, get-annotations
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "scanpy";
    meta = {
      description = "Single-Cell Analysis in Python";
      license = lib.licenses.bsd3;
      homepage = "https://scanpy.readthedocs.io/en/stable/";
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
  format = if hatch
    then "pyproject"
    else "flit";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = if hatch then [ 
    hatchling hatch-vcs 
  ] else [ 
    setuptools-scm flit-core
  ];

  propagatedBuildInputs = [
    anndata
    numpy
    matplotlib
    pandas
    scipy
    seaborn
    h5py
    tqdm
    scikit-learn
    statsmodels
    patsy
    networkx
    natsort
    joblib
    numba
    umap-learn
    packaging
    session-info
    get-annotations
  ];
}) (import ./releases.nix)
