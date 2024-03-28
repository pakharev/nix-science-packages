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
, legacy-api-wrap
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "scanpy";
  meta = {
    description = "Single-Cell Analysis in Python";
    homepage = "https://scanpy.readthedocs.io/";
    license = lib.licenses.bsd3;
  };
} 

(conf: {
  pyproject = true;
  disabled = pythonOlder "3.8";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "scverse";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = if conf ? hatch then [ 
    hatchling hatch-vcs 
  ] else [ 
    setuptools-scm flit-core
  ];

  dependencies = [
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
    legacy-api-wrap
  ];
})) (import ./releases.nix)
