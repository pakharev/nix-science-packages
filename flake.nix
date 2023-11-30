{
  description = "An assortment of R and Python packages";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
  };
  outputs = inputs: import ./. inputs;
}
