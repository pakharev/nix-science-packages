final: prev: {
  rstudio = final.libsForQt5.callPackage ./rstudio {
    jdk = final.jdk8;
  };
}
