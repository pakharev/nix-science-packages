{ lib
, buildPythonPackage
, setuptools-scm
, six
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}:
with info; buildPythonPackage {
  format = "setuptools";

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    six
  ];

  inherit pname version;
  src = fetchSource fetcher;
  meta = meta // { inherit allReleases release info; };
}