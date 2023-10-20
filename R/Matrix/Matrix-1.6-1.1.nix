{ rPackages
, fetchzip
, lib
}: let
  depends = with rPackages; [ 
    lattice 
  ];
in rPackages.buildRPackage {
  name = "Matrix";
  version = "1.6-1.1";
  src = fetchzip {
    name = "cran-Matrix_1.6-1.1.tar.gz";
    url = "https://cran.r-project.org/src/contrib/Matrix_1.6-1.1.tar.gz";
    sha256 = "sha256-/DCiOU4aLA+k9Msj3mTegy8e8k6bTnma6RGLU493K8c=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
