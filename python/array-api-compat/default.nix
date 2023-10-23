{ lib
, buildPythonPackage
, setuptools-scm
, pythonOlder
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}:
with info; buildPythonPackage {
  format = "setuptools";
  disabled = pythonOlder "3.7";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  # requires too much
  doCheck = false;

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}
