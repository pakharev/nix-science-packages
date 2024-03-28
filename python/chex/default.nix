{ lib
, buildPythonPackage
, setuptools-scm
, absl-py
, cloudpickle
, dm-tree
, jax
, jaxlib
, numpy
, pytest
, toolz
, typing-extensions
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "chex";
  meta = {
    description = "Chex is a library of utilities for helping to write reliable JAX code.";
    homepage = "https://github.com/deepmind/chex/";
    license = lib.licenses.asl20;
  };
} 

(conf: {
  pyproject = true;
  fetchers.src = "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  dev = GitHub.override (conf: {
    owner = "google-deepmind";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [ 
    setuptools-scm
  ];

  dependencies = [
    absl-py
    jaxlib
    jax
    numpy
    toolz
    typing-extensions
  ];

  doCheck = false;

})) (import ./releases.nix)
