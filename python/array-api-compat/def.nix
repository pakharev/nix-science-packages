{ lib
, buildPythonPackage
, fetchSource
, setuptools-scm
, pythonOlder
, versions ? import ./versions.nix lib
, info ? builtins.head versions
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
  meta = info.meta // { inherit info versions; };
}
