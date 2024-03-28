{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "array-api-compat";
  meta = {
    description = "Array API compatibility library";
    homepage = "https://github.com/data-apis/array-api-compat/";
    license = lib.licenses.mit;
  };
} 

(conf: {
  pyproject = true;
  disabled = pythonOlder "3.7";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  PyPI = PyPI.override {
    pname = "array_api_compat";
  };
  dev = GitHub.override (conf: {
    owner = "data-apis";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    setuptools-scm
  ];

})) (import ./releases.nix)
