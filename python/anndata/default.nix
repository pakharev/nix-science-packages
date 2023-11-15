{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchPypi
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
, releases ? import ./releases.nix
}@args: lib.pipe releases [
  builtins.head
  buildPythonPackage
]
#   (r: {
#     platform = "python";
#     pname = "anndata";
#     hatch = false;
#   } // r)
#   lib.versionFromDev
# ]
# 
#  (r: lib.recursiveUpdate {
#    fetchers = {
#      src = if (r.resources ? "srcPyPI") then
#        "srcPyPI"
#      else
#        "srcDev";
#    };
#  } r)
#  (with lib.mirrors; resolve args {
#    inherit PyPI;
#    dev = r: generic "dev" r // {
#      method = "fetchFromGitHub";
#      owner = "scverse";
#      repo = r.pname;
#      rev = r.version;
#    };
#  })
#
#  (r: lib.recursiveUpdate {
#    meta = {
#      inherit releases;
#      description = "Annotated data";
#      license = lib.licenses.bsd3;
#      homepage = "https://anndata.readthedocs.io/";
#      changelog = "https://anndata.readthedocs.io/en/latest/#latest-additions";
#    };
#  } r)
#
#  (r: with r; {
#    inherit pname version src meta;
#
#    format = if hatch
#      then "pyproject"
#      else "flit";
#    disabled = pythonOlder "3.8";
#
#    SETUPTOOLS_SCM_PRETEND_VERSION = version;
#  
#    nativeBuildInputs = if hatch then [ 
#      hatchling hatch-vcs 
#    ] else [ 
#      setuptools-scm flit-core
#    ];
#  
#    propagatedBuildInputs = [
#      pandas
#      numpy
#      scipy
#      h5py
#      natsort
#      packaging
#    ] ++ lib.optionals hatch [
#      array-api-compat
#      exceptiongroup
#    ];
#  })
#
#  buildPythonPackage
#]
