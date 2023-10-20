{ rPackages
, fetchzip
, lib
}:
rPackages.buildRPackage {
  name = "quadprog";
  version = "1.5-8";
  src = fetchzip {
    name = "cran-quadprog_1.5-8.tar.gz";
    url = "https://cran.r-project.org/src/contrib/quadprog_1.5-8.tar.gz";
    sha256 = "sha256-zOkrH9Q4bm+iEfJ+n8FCHgVfzx0QBwIHoxzFP1R9tdM=";
  };
  propagatedBuildInputs = with rPackages; [
  ];
} 
