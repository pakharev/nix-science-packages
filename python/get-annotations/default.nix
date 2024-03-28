{ lib
, buildPythonPackage
, setuptools-scm
, poetry-core
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "get-annotations";
  meta = {
    description = "A backport of Python 3.10 get_annotations() function";
    homepage = "https://github.com/shawwn/get-annotations";
    license = lib.licenses.mit;
  };
} 

(conf: {
  pyproject = true;
  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = GitHub.override (conf: {
    owner = "shawwn";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  build-system = [
    setuptools-scm poetry-core
  ];
})) (import ./releases.nix)
