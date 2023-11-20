final: prev: {
  python = final.python310.override {
    packageOverrides = (self: super: {
      anndata = self.callPackage ./anndata {};
      array-api-compat = self.callPackage ./array-api-compat {};
      numpy-groupies = self.callPackage ./numpy-groupies {};
      get-annotations = self.callPackage ./get-annotations {};
      session-info = self.callPackage ./session-info {};
      mudata = self.callPackage ./mudata {};
      loompy = self.callPackage ./loompy {};
      scanpy = self.callPackage ./scanpy {};
      scvi-tools = self.callPackage ./scvi-tools {};
      scvelo = self.callPackage ./scvelo {};
      unitvelo = self.callPackage ./unitvelo {};
      iprogress = self.callPackage ./iprogress {};
      flax = self.callPackage ./flax {};

      tensorflow = self.tensorflow-bin;
    });
  };
}
