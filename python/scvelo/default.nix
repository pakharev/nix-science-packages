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
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
with info; buildPythonPackage {
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

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
