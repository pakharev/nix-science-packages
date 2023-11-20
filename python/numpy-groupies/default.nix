{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, numpy
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "numpy-groupies";
  meta = {
    description = "Optimised tools for group-indexing operations: aggregated sum and more";
    homepage = "https://github.com/ml31415/numpy-groupies";
    license = lib.licenses.bsd2;
  };
} 

(conf: {
  format = "pyproject";
  disabled = pythonOlder "3.8";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "ml31415";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    numpy
  ];
})) (import ./releases.nix)
