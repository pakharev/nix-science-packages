{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
    rprojroot
  ];
in rPackages.buildRPackage {
  name = "here";
  version = "1.0.1.9005";
  src = fetchFromGitHub {
    owner = "r-lib";
    repo = "here";
    rev = "2c187aefed3a9a5277f2f03c5d41a38dbf4d59d7";
    sha256 = "sha256-nCtEaWJ+JAYIZ5QFeCt1hCsP/6T8gBxGLmNS/6L7qgQ=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
