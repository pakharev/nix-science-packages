{ lib
, buildPythonPackage
, hatchling
, setuptools-scm
, pythonOlder
, anndata
, scanpy
, loompy
, umap-learn
, numba
, numpy
, pandas
, scipy
, scikit-learn
, scvi-tools
, matplotlib
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "scvelo";
  meta = {
    description = "RNA velocity generalized through dynamical modeling";
    homepage = "https://scvelo.readthedocs.io/en/stable/";
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
    owner = "theislab";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [ 
    hatchling
    setuptools-scm
  ];

  dependencies = [
    anndata
    scanpy
    loompy
    umap-learn
    numba
    numpy
    pandas
    scipy
    scikit-learn
    scvi-tools
    matplotlib
  ];
})) (import ./releases.nix)
