{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, pandas
, numpy
, h5py
, anndata
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
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

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
