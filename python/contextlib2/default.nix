{ lib
, buildPythonPackage
, setuptools-scm
, pythonAtLeast
, pythonOlder
, unittestCheckHook
, fetchPypi
, fetchFromGitHub
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "contextlib2";
  meta = {
    description = "Backports and enhancements for the contextlib module";
    license = lib.licenses.psfl;
    homepage = "https://contextlib2.readthedocs.org/";
  };
} 

(conf: {
  pyproject = true;
  disabled = pythonOlder "3.6" || pythonAtLeast "3.12";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "alvistack";
    repo = "jazzband-contextlib2";
    rev = "refs/tags/release-${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    setuptools-scm
  ];

  nativeCheckInputs = [ 
    unittestCheckHook
  ];

  pythonImportsCheck = [
    "contextlib2"
  ];
})) (import ./releases.nix)
