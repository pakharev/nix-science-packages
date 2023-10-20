{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "rappdirs";
  src = fetchSource (import ./src.nix).${version};
  version = "0.3.3";
  src = fetchFromGitHub {
    owner = "r-lib";
    repo = "rappdirs";
    rev = "v0.3.3";
    sha256 = "sha256-k/lHm5Hnon8xo7ZDwQm4uCqPHNbCtHxTc2uHwuJCZMU=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
