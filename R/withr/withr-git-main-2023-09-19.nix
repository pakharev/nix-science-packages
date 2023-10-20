{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "withr";
  version = "git-main-2023-09-19";
  src = fetchFromGitHub {
    owner = "r-lib";
    repo = "withr";
    rev = "687f3a39c603622aea3bc54c3decbb379972b0f3";
    sha256 = "sha256-i0UvuMrIO+ia0cEHnUO0GZbKHDTpmvSSM2+owx0Y4Y8=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
} 
