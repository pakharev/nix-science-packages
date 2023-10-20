{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "rlang";
  version = "git-main-2023-06-07";
  src = fetchFromGitHub {
    owner = "r-lib";
    repo = "rlang";
    rev = "c55f6027928d3104ed449e591e8a225fcaf55e13";
    sha256 = "sha256-NH5Qf/VZ8EOtPU4eucuwHESESi4d8suKk6T8++0ebDM=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
  preConfigure = "patchShebangs configure";
}
