{ rPackages
, fetchzip
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "RcppProgress";
  version = "0.4.2";
  src = fetchzip {
    name = "cran-RcppProgress_0.4.2.tar.gz";
    url = "https://cran.r-project.org/src/contrib/RcppProgress_0.4.2.tar.gz";
    sha256 = "sha256-yu6soHIJaClWl58iC8aTIPiTv/kXj1LjzeEaoskE+7M=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
