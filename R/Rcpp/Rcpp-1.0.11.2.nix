{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "Rcpp";
  version = "1.0.11.2";
  src = fetchFromGitHub {
    owner = "RcppCore";
    repo = "Rcpp";
    rev = "62bb38178399b061d34b8f838d45a4730cb03fbb";
    sha256 = "sha256-i9ODeC3k9a3jxYIvkPbTwZJTlEWhNAiRWG6Lgk9oXLs=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
