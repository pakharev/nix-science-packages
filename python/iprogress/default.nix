{ lib
, buildPythonPackage
, setuptools-scm
, six
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "IProgress";
  meta = {
    description = "Text progress bar library for Python";
    homepage = "https://github.com/aebrahim/IProgress";
    license = lib.licenses.mit;
  };
} 

(conf: {
  format = "setuptools";
  fetchers.src = "srcPyPI";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    six
  ];
})) (import ./releases.nix)
