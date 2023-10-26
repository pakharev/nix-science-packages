final: prev: {
  rstudio = prev.libsForQt5.callPackage ./rstudio {
    inherit (prev.yarn2nix-moretea) fixup_yarn_lock;
    jdk = prev.jdk8;
    patchShebangs = prev.callPackage ./rstudio/patch-shebangs.nix {};
  };
}
