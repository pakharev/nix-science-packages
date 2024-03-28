{ lib
, buildPythonPackage
, hatchling
, pythonOlder
, anndata
, chex
, docrep
, flax
, jax
, jaxlib
, optax
, numpy
, pandas
, scipy
, scikit-learn
, rich
, h5py
, torch
, lightning
, torchmetrics
, pyro-ppl
, tqdm
, numpyro
, ml-collections
, mudata
, sparse
, xarray
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "scvi-tools";
  meta = {
    description = "Probabilistic models for single-cell omics data";
    homepage = "https://scvi-tools.org/";
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
  PyPI = PyPI.override {
    pname = "scvi_tools";
  };
  dev = GitHub.override (conf: {
    owner = "scverse";
    rev = let
      prefix = lib.optionalString (conf.version < "1.") "v";
    in "refs/tags/${prefix}${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [ 
    hatchling
  ];

  dependencies = [
    anndata
    chex
    docrep
    flax
    jax
    jaxlib
    optax
    numpy
    pandas
    scipy
    scikit-learn
    rich
    h5py
    torch
    lightning
    torchmetrics
    pyro-ppl
    tqdm
    numpyro
    ml-collections
    mudata
    sparse
    xarray
  ];
})) (import ./releases.nix)
