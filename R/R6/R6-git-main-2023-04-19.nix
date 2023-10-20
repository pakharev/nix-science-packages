{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "R6";
  version = "git-main-2023-04-19";
  src = fetchFromGitHub {
    owner = "r-lib";
    repo = "R6";
    rev = "e97cca79f5b9eef029330ca45b765cdc9e249f29";
    sha256 = "sha256-e+JBnomBtfPMQLOaSrC1zL7ZolEeFWdYD35ckFYBExE=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
