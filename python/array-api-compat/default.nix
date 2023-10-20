{ lib
, buildPythonPackage
, fetchSource
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
, allReleases ? import ./releases.nix
, release ? builtins.head releases
, info ? (import ./info.nix) lib release
}: let
  inherit (info) hatch;
in buildPythonPackage {
  format = if hatch
    then "pyproject"
    else "flit";
  disabled = pythonOlder "3.8";

  SETUPTOOLS_SCM_PRETEND_VERSION = info.version;

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

  inherit (info) pname version;
  src = fetchSource info;
  meta = info.meta // { inherit allReleases release info; };
}
