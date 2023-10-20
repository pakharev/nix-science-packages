{ rPackages
, fetchFromGitHub
, lib
}: let
  depends = with rPackages; [
  ];
in rPackages.buildRPackage {
  name = "distances";
  version = "0.1.9";
  src = fetchFromGitHub {
    owner = "fsavje";
    repo = "distances";
    rev = "v0.1.9";
    sha256 = "sha256-pxVx4U+zOwmmm2cdrZBJ0A4hVUnN7aznwQCnYiGTBzY=";
  };
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
}
