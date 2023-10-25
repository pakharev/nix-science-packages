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
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
  format = "pyproject";
  disabled = pythonOlder "3.5";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

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

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
