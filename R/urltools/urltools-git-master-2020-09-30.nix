{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
    Rcpp
    triebeard
  ];
in rPackages.buildRPackage {
  name = "urltools";
  version = "git-master-2020-09-30";
  src = fetchFromGitHub {
    owner = "Ironholds";
    repo = "urltools";
    rev = "ccdd1b4adefe6743fb88f4f2b078811d75de0c9c";
    sha256 = "sha256-IqQAOXoRPl8BGUMq36XJKFXBqinVZG9XPaPNHXUL924=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
