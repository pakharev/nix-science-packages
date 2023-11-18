{ lib
, buildPythonPackage
, hatchling
, pythonOlder
, anndata
, scanpy
, loompy
, umap-learn
, numba
, numpy
, pandas
, scipy
, scikit-learn
, scvi-tools
, matplotlib
, fetchFromGitHub
, fetchPypi
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "scvelo";
    meta = {
      description = "RNA velocity generalized through dynamical modeling";
      license = lib.licenses.bsd3;
      homepage = "https://scvelo.readthedocs.io/en/stable/";
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override (conf: {
      owner = "theislab";
      rev = "refs/tags/v${conf.version}";
    });
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "pyproject";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ 
    hatchling
  ];

  propagatedBuildInputs = [
    anndata
    scanpy
    loompy
    umap-learn
    numba
    numpy
    pandas
    scipy
    scikit-learn
    scvi-tools
    matplotlib
  ];
}
