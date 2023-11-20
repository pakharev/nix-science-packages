{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, pandas
, numpy
, h5py
, anndata
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "mudata";
  meta = {
    description = "Multimodal data";
    license = lib.licenses.bsd3;
    homepage = "https://mudata.readthedocs.io/";
  };
} 

(conf: {
  format = "flit";
  disabled = pythonOlder "3.7";

  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "scverse";
    rev = "refs/tags/v${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  nativeBuildInputs = [ 
    setuptools-scm 
  ];

  propagatedBuildInputs = [
    pandas
    numpy
    h5py
    anndata
  ];
})) (import ./releases.nix)
