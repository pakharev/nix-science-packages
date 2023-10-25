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
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
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

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
