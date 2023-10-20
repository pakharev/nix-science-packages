{ rPackages
, fetchzip
, lib
}: let
  depends = with rPackages; [
    Rcpp
  ];                                                      
in rPackages.buildRPackage {
  name = "triebeard";
  version = "0.4.1";
  src = fetchzip {
    name = "cran-triebeard_0.4.1.tar.gz";
    url = "https://cran.r-project.org/src/contrib/triebeard_0.4.1.tar.gz";
    sha256 = "sha256-jpHQJHc4FY4EMFDceJE5CLrMeKJOrjgFbpom9BnRPOw=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
