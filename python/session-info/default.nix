{ lib
, buildPythonPackage
, setuptools-scm
, stdlib-list
, fetchFromGitHub
, fetchPypi
}@deps: with lib.packageConfigs; (trivial 

{
  pname = "session_info";
  meta = {
    description = "Print version information for loaded modules in the current session, Python, and the OS";
    homepage = "https://gitlab.com/joelostblom/session_info";
    license = lib.licenses.bsd3;
  };
} 

(conf: {
  format = "setuptools";
  fetchers.src = if (conf.sources ? "srcPyPI") then "srcPyPI" else "srcDev";
}) 

devVersion.PEP440 

(with commonLocations; resolveLocations {
  inherit PyPI;
  dev = (generic "GitLab").override (conf: {
    method = "fetchFromGitLab";
    owner = "joelostblom";
    repo = "session_info";
    rev = "refs/tags/${conf.version}";
  });
}) 

).eval (conf: buildPythonPackage (populateFetchers deps conf // {
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    stdlib-list
  ];
})) (import ./releases.nix)
