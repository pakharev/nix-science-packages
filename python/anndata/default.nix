{ lib
, buildPythonPackage
, setuptools-scm
, flit-core
, hatchling
, hatch-vcs
, pythonOlder
, pandas
, numpy
, scipy
, h5py
, natsort
, packaging
, exceptiongroup
, array-api-compat
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "anndata";
  meta = {
    description = "Annotated data";
    homepage = "https://anndata.readthedocs.io/";
    changelog = "https://anndata.readthedocs.io/en/latest/#latest-additions";
    license = lib.licenses.bsd3;
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
    owner = "scverse";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  nativeBuildInputs = if conf ? hatch then [ 
    hatchling hatch-vcs 
  ] else [ 
    setuptools-scm flit-core
  ];

  propagatedBuildInputs = [
    pandas
    numpy
    scipy
    h5py
    natsort
    packaging
  ] ++ lib.optionals (conf ? hatch) [
    array-api-compat
    exceptiongroup
  ];
})) (import ./releases.nix)
