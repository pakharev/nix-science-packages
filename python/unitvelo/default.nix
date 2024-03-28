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
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "unitvelo";
  meta = {
    description = "UniTVelo for RNA Velocity Analysis";
    homepage = "https://unitvelo.readthedocs.io/en/latest/";
    license = lib.licenses.bsd3;
  };
} 

(conf: {
  pyproject = true;
  disabled = pythonOlder "3.7";

  fetchers.src = "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  dev = GitHub.override (conf: {
    owner = "StatBiomed";
    repo = "UniTVelo";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [ 
    setuptools-scm
  ];

  dependencies = [
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

  # No tests in archive
  doCheck = false;
})) (import ./releases.nix)
