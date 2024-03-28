{ lib
, buildPythonPackage
, setuptools
, wheel
, pythonOlder
, nss
, nspr
, expat
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "kaleido";
  meta = {
    description = "Image export";
    license = lib.licenses.mit;
    #homepage = "";
  };
} 

(conf: {
  format = "wheel";
  fetchers.src = "srcPyPI";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  PyPI = PyPI.override {
    platform = "manylinux1_x86_64";
    format = "wheel";
  };
}) 

).eval (conf: let
  rpath = lib.makeLibraryPath [
    nss
    nspr
    expat
  ];
in buildPythonPackage (populateFetchers deps conf // {

  build-system = [ 
    setuptools
    wheel
  ];

  doCheck = false;

  postFixup = ''
    for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* \) ); do
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$file" || true
      patchelf --set-rpath ${rpath}:$out/lib/x86_64-linux-gnu $file || true
    done
    sed -i 's,#!/bin/bash,#!/usr/bin/env bash,' $out/lib/python3.11/site-packages/kaleido/executable/kaleido
  '';

})) (import ./releases.nix)
