{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, numpy
, scikit-learn
, pandas
, scipy
, seaborn
, matplotlib
, tqdm
, scanpy
, statsmodels
, anndata
, scvelo
, iprogress
, ipykernel
, ipywidgets
, ipython
, jupyter
, tensorflow
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
  format = "setuptools";
  disabled = pythonOlder "3.7";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ 
    setuptools-scm 
  ];

  propagatedBuildInputs = [
    numpy
    scikit-learn
    pandas
    scipy
    seaborn
    matplotlib
    tqdm
    scanpy
    statsmodels
    anndata
    scvelo
    iprogress
    ipykernel
    ipywidgets
    ipython
    jupyter
    tensorflow
  ];

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
