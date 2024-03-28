{ lib
, buildPythonPackage
, setuptools-scm
, importlib-metadata
, joblib
, llvmlite
, numba
, scikit-learn
, scipy
, pytest
, pythonOlder
, fetchPypi
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "pynndescent";
  meta = {
    description = "Python nearest neighbor descent for approximate nearest neighbors";
    license = lib.licenses.bsd2;
    homepage = "https://pynndescent.readthedocs.io";
  };
} 

(conf: {
  pyproject = true;
  disabled = pythonOlder "3.6";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "lmcinnes";
    rev = "refs/tags/release-${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    setuptools-scm
  ];

  dependencies = [
    joblib
    llvmlite
    numba
    scikit-learn
    scipy
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  nativeCheckInputs = [
    pytest
  ];

  disabledTests = [
    # numpy.core._exceptions._UFuncNoLoopError
    "test_sparse_nn_descent_query_accuracy_angular"
    "test_nn_descent_query_accuracy_angular"
    "test_alternative_distances"
    # scipy: ValueError: Unknown Distance Metric: wminkowski
    # https://github.com/scikit-learn/scikit-learn/pull/21741
    "test_weighted_minkowski"
  ];

  pythonImportsCheck = [
    "pynndescent"
  ];
})) (import ./releases.nix)
