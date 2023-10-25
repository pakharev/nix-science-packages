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
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
  format = "pyproject";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ 
    hatchling
  ];

  propagatedBuildInputs = [
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

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
