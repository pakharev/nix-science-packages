{ lib
, buildPythonPackage
, fetchSource
, setuptools-scm
, pythonOlder
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}:

buildPythonPackage {
  format = "setuptools";
  disabled = pythonOlder "3.7";

  SETUPTOOLS_SCM_PRETEND_VERSION = info.version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  # requires too much
  doCheck = false;

  inherit (info) pname version;
  src = fetchSource info;
  meta = info.meta // { inherit allReleases release info; };
}
