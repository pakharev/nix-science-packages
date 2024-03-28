{ lib
, buildPythonPackage
, setuptools-scm
, flit-core
, absl-py
, chex
, jaxlib
, numpy
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "optax";
  meta = {
    description = "Gradient processing and optimization library for JAX";
    homepage = "https://github.com/deepmind/optax/";
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
    owner = "deepmind";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [ 
    setuptools-scm
    flit-core
  ];

  buildInputs = [
    jaxlib
  ];

  dependencies = [
    absl-py
    chex
    numpy
  ];

  doCheck = false;

})) (import ./releases.nix)
