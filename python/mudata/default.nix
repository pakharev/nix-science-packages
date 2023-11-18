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
}@deps: with lib.configurablePackages; makeOverridableConfigs (configs: let
  config = builtins.head configs;
  defaults = lib.recursiveUpdate {
    pname = "mudata";
    meta = {
      description = "Multimodal data";
      license = lib.licenses.bsd3;
      homepage = "https://mudata.readthedocs.io/";
      inherit configs;
    };
    fetchers.src = if (config.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
  } (versionFromDev config);
  locations = with commonLocations; {
    inherit PyPI;
    dev = GitHub.override (conf: {
      owner = "scverse";
      rev = "refs/tags/v${conf.version}";
    });
  };
  final = resolveFetchers {
    inherit deps locations;
  } defaults;
in with final; buildPythonPackage {
  inherit pname version src meta;
  format = "flit";
  disabled = pythonOlder "3.7";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ 
    setuptools-scm 
  ];

  propagatedBuildInputs = [
    pandas
    numpy
    h5py
    anndata
  ];
}) (import ./releases.nix)
