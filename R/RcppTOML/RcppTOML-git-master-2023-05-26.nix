{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
    Rcpp                                                  
  ];                                                      
in rPackages.buildRPackage {
  name = "RcppTOML";
  version = "git-master-2023-05-26";
  src = fetchFromGitHub {
    owner = "eddelbuettel";
    repo = "rcpptoml";
    rev = "415aa799d172113aa8cec7910810e048bfed5da6";
    sha256 = "sha256-FSCAYvL1jP/CPbPpP6HPKENwg7HdjBZ7US2RG5x+aM0=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
