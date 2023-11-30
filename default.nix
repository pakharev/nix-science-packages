{ self, nixpkgs }: let
  pkgs = import nixpkgs {
    system = "x86_64-linux";
    overlays = [
      (import ./lib)
      (import ./R)
      (import ./python)
      (import ./applications)
    ];
  };
in {
  legacyPackages.${pkgs.system} = pkgs;
}
