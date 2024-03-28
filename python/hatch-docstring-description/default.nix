{ lib
, buildPythonPackage
, hatchling
, hatch-vcs
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "hatch-docstring-description";
  meta = {
    description = "Hatch Docstring Description";
    homepage = "https://github.com/flying-sheep/hatch-docstring-description/";
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
    pname = "hatch_docstring_description";
  };
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    hatchling
    hatch-vcs
  ];
})) (import ./releases.nix)
