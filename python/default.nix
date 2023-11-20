final: prev: {
  python = final.python310.override {
    packageOverrides = (self: super: {
      anndata = self.callPackage ./anndata {};
      array-api-compat = self.callPackage ./array-api-compat {};
      flax = self.callPackage ./flax {};
      get-annotations = self.callPackage ./get-annotations {};
      iprogress = self.callPackage ./iprogress {};
      loompy = self.callPackage ./loompy {};
      mudata = self.callPackage ./mudata {};
      numpy-groupies = self.callPackage ./numpy-groupies {};
      scanpy = self.callPackage ./scanpy {};
      scvelo = self.callPackage ./scvelo {};
      scvi-tools = self.callPackage ./scvi-tools {};
      session-info = self.callPackage ./session-info {};
      umap-learn = self.callPackage ./umap-learn {};
      unitvelo = self.callPackage ./unitvelo {};

      tensorflow = self.tensorflow-bin;
    });
  };
}
