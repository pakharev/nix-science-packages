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
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "scvi-tools";
    meta = {
      description = "Probabilistic models for single-cell omics data";
      license = lib.licenses.bsd3;
      homepage = "https://scvi-tools.org/";
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    PyPI = PyPI.override {
      pname = "scvi_tools";
    };
    dev = GitHub.override (conf: {
      owner = "scverse";
      rev = let
        prefix = lib.optionalString (conf.version < "1.") "v";
      in "refs/tags/${prefix}${conf.version}";
    });
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
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
}
