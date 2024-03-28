{ lib
, buildPythonPackage
, pytest
, pythonOlder
, setuptools-scm
, dask
, numba
, numpy
, scipy
, pytest-cov
, pre-commit
, fetchPypi
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "sparse";
  meta = {
    description = "Sparse n-dimensional arrays computations";
    license = lib.licenses.bsd3;
    homepage = "https://sparse.pydata.org/";
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
    owner = "pydata";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    setuptools-scm
  ];

  dependencies = [
    numba
    numpy
    scipy
  ];

  nativeCheckInputs = [
    dask
    pytest-cov
    pre-commit
    pytest
  ];

  pythonImportsCheck = [
    "sparse"
  ];

  disabledTestPaths = [
    # Too premature.
    "tests/test_backends.py"
  ];
})) (import ./releases.nix)
