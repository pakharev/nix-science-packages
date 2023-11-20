{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchPypi
, keras
, numba
, numpy
, pynndescent
, pytestCheckHook
, pythonOlder
, scikit-learn
, scipy
, tensorflow
, tqdm
, tbb
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "umap-learn";
  meta = {
    description = "Uniform Manifold Approximation and Projection";
    homepage = "https://umap-learn.readthedocs.io";
    license = lib.licenses.bsd3;
  };
} 

(conf: {
  format = "setuptools";
  disabled = pythonOlder "3.7";

  fetchers.src = if (conf.sources ? "srcDev") then "srcDev" else "srcPyPI";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "lmcinnes";
    repo = "umap";
    rev = let
      prefix = lib.optionalString (conf.version >= "0.5.5") "release-";
    in "refs/tags/${prefix}${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {

  propagatedBuildInputs = [
    numba
    numpy
    pynndescent
    scikit-learn
    scipy
    tqdm
    tbb
  ];

  nativeCheckInputs = [
    keras
    pytestCheckHook
    tensorflow
  ];

  preCheck = ''
    export HOME=$TMPDIR
  '';

  disabledTests = [
    # Plot functionality requires additional packages.
    # These test also fail with 'RuntimeError: cannot cache function' error.
    "test_umap_plot_testability"
    "test_plot_runs_at_all"

    # Flaky test. Fails with AssertionError sometimes.
    "test_sparse_hellinger"
    "test_densmap_trustworthiness_on_iris_supervised"

    # tensorflow maybe incompatible? https://github.com/lmcinnes/umap/issues/821
    "test_save_load"
  ];

})) (import ./releases.nix)
