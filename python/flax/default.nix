{ buildPythonPackage
, setuptools-scm
, jaxlib
, jax
, keras
, lib
, matplotlib
, msgpack
, numpy
, einops
, optax
, pytest-xdist
, pytest
, pythonRelaxDepsHook
, pyyaml
, tensorflow
, tensorstore
, rich
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "flax";
  meta = {
    description = "Neural network library for JAX";
    homepage = "https://github.com/google/flax";
    license = lib.licenses.asl20;
  };
} 

(conf: {
  pyproject = true;
  fetchers.src = "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "google";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [ 
    setuptools-scm
    jaxlib pythonRelaxDepsHook 
  ];

  dependencies = [
    jax
    matplotlib
    msgpack
    numpy
    einops
    optax
    rich
    tensorstore
  ] ++ lib.optionals (conf.version >= "0.8.0") [
    pyyaml
  ];

  # See https://github.com/google/flax/pull/2882.
  pythonRemoveDeps = [ "orbax" ];

  pythonImportsCheck = [
    "flax"
  ];

  nativeCheckInputs = [
    keras
    pytest-xdist
    pytest
    tensorflow
  ];

  pytestFlagsArray = [
    "-W ignore::FutureWarning"
    "-W ignore::DeprecationWarning"
  ];

  disabledTestPaths = [
    # Docs test, needs extra deps + we're not interested in it.
    "docs/_ext/codediff_test.py"

    # The tests in `examples` are not designed to be executed from a single test
    # session and thus either have the modules that conflict with each other or
    # wrong import paths, depending on how they're invoked. Many tests also have
    # dependencies that are not packaged in `nixpkgs` (`clu`, `jgraph`,
    # `tensorflow_datasets`, `vocabulary`) so the benefits of trying to run them
    # would be limited anyway.
    "examples/*"

    # See https://github.com/google/flax/issues/3232.
    "tests/jax_utils_test.py"

    # Requires orbax which is not packaged as of 2023-07-27.
    "tests/checkpoints_test.py"
  ];

  disabledTests = [
    # See https://github.com/google/flax/issues/2554.
    "test_async_save_checkpoints"
    "test_jax_array0"
    "test_jax_array1"
    "test_keep0"
    "test_keep1"
    "test_optimized_lstm_cell_matches_regular"
    "test_overwrite_checkpoints"
    "test_save_restore_checkpoints_target_empty"
    "test_save_restore_checkpoints_target_none"
    "test_save_restore_checkpoints_target_singular"
    "test_save_restore_checkpoints_w_float_steps"
    "test_save_restore_checkpoints"
    "test_cloudpickle_module"
  ];
})) (import ./releases.nix)
