{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "rprojroot";
  version = "git-main-2023-08-30";
  src = fetchFromGitHub {
    owner = "r-lib";
    repo = "rprojroot";
    rev = "d93914af95d84297f5c7f0199639bc72440f0a33";
    sha256 = "sha256-Zv5LQWrWSU9fcr+V3+vtHHe6I7ytHzdNNoHq4VpRBBE=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
