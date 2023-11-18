{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, numpy
, scikit-learn
, pandas
, scipy
, seaborn
, matplotlib
, tqdm
, scanpy
, statsmodels
, anndata
, scvelo
, iprogress
, ipykernel
, ipywidgets
, ipython
, jupyter
, tensorflow
, fetchFromGitHub
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "unitvelo";
    meta = {
      description = "UniTVelo for RNA Velocity Analysis";
      license = lib.licenses.bsd3;
      homepage = "https://unitvelo.readthedocs.io/en/latest/";
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    dev = GitHub.override (conf: {
      owner = "StatBiomed";
      repo = "UniTVelo";
      rev = "refs/tags/v${conf.version}";
    });
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "setuptools";
  disabled = pythonOlder "3.7";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ 
    setuptools-scm 
  ];

  propagatedBuildInputs = [
    numpy
    scikit-learn
    pandas
    scipy
    seaborn
    matplotlib
    tqdm
    scanpy
    statsmodels
    anndata
    scvelo
    iprogress
    ipykernel
    ipywidgets
    ipython
    jupyter
    tensorflow
  ];
}
