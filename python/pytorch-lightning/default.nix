{ lib
, buildPythonPackage
, setuptools-scm
, fsspec
, lightning-utilities
, numpy
, packaging
, pyyaml
, tensorboardx
, torch
, torchmetrics
, tqdm
, traitlets
, fetchPypi
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "lightning";
  meta = {
    description = "Lightweight PyTorch wrapper for machine learning researchers";
    license = lib.licenses.asl20;
    homepage = "https://pytorch-lightning.readthedocs.io";
  };
} 

(conf: {
  pyproject = true;
  fetchers.src = "srcPyPI";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    setuptools-scm
  ];

  dependencies = [
    fsspec
    numpy
    packaging
    pyyaml
    tensorboardx
    torch
    lightning-utilities
    torchmetrics
    tqdm
    traitlets
  ]
  ++ fsspec.optional-dependencies.http;

  # Some packages are not in NixPkgs; other tests try to build distributed
  # models, which doesn't work in the sandbox.
  doCheck = false;

  pythonImportsCheck = [
    "lightning"
  ];
})) (import ./releases.nix)
