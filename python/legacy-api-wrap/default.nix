{ lib
, buildPythonPackage
, hatchling
, hatch-vcs
, hatch-docstring-description
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "legacy-api-wrap";
  meta = {
    description = "A decorator to wrap legacy APIs";
    homepage = "https://github.com/flying-sheep/legacy-api-wrap";
    license = lib.licenses.gpl3;
  };
} 

(conf: {
  pyproject = true;
  fetchers.src = "srcPyPI";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  PyPI = PyPI.override {
    pname = "legacy_api_wrap";
  };
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    hatchling
    hatch-vcs
    hatch-docstring-description
  ];

  doCheck = false;
})) (import ./releases.nix)
