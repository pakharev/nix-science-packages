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
, pytestCheckHook
, pythonRelaxDepsHook
, tensorflow
, tensorstore
, rich
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
  format = "pyproject";

  nativeBuildInputs = [ 
    setuptools-scm
    jaxlib pythonRelaxDepsHook 
  ];

  propagatedBuildInputs = [
    jax
    matplotlib
    msgpack
    numpy
    einops
    optax
    rich
    tensorstore
  ];

  # See https://github.com/google/flax/pull/2882.
  pythonRemoveDeps = [ "orbax" ];

  pythonImportsCheck = [
    "flax"
  ];

  nativeCheckInputs = [
    keras
    pytest-xdist
    pytestCheckHook
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

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}