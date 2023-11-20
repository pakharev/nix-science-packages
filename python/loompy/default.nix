{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, numpy
, scipy
, h5py
, numba
, click
, numpy-groupies
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "loompy";
  meta = {
    description = "Loom is an efficient file format for large omics datasets";
    homepage = "http://loompy.org/";
    license = lib.licenses.bsd2;
  };
} 

(conf: {
  format = "pyproject";
  disabled = pythonOlder "3.5";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "linnarsson-lab";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  nativeBuildInputs = [ 
    setuptools-scm
  ];

  propagatedBuildInputs = [
    numpy
    scipy
    h5py
    numba
    click
    numpy-groupies
  ];
})) (import ./releases.nix)
