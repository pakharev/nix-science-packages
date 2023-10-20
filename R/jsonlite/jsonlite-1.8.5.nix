{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "jsonlite";
  version = "1.8.5";
  src = fetchFromGitHub {
    owner = "jeroen";
    repo = "jsonlite";
    rev = "v1.8.5";
    sha256 = "sha256-NBpC48bfswvV6dDsyZxE4YN4+VpL1jXkE4tJgULsy+Q=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
