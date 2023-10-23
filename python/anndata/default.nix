{ lib
, buildPythonPackage
, setuptools-scm
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
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
  format = if hatch
    then "pyproject"
    else "flit";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = if hatch then [ 
    hatchling hatch-vcs 
  ] else [ 
    setuptools-scm 
  ];

  propagatedBuildInputs = [
    pandas
    numpy
    scipy
    h5py
    natsort
    packaging
  ] ++ lib.optionals hatch [
    array-api-compat
    exceptiongroup
  ];

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
