final: prev: {
  python = final.python311.override {
    packageOverrides = (self: super: {
      anndata = self.callPackage ./anndata {};
      array-api-compat = (self.callPackage ./array-api-compat {}).overridePythonAttrs {
        doCheck = false;
      };
      chex = self.callPackage ./chex {};
      contextlib2 = self.callPackage ./contextlib2 {};
      flax = self.callPackage ./flax {};
      get-annotations = self.callPackage ./get-annotations {};
      hatch-docstring-description = self.callPackage ./hatch-docstring-description {};
      iprogress = self.callPackage ./iprogress {};
      kaleido = self.callPackage ./kaleido {};
      legacy-api-wrap = self.callPackage ./legacy-api-wrap {};
      lightning = self.callPackage ./lightning {};
      loompy = self.callPackage ./loompy {};
      mudata = self.callPackage ./mudata {};
      numpy-groupies = self.callPackage ./numpy-groupies {};
      optax = self.callPackage ./optax {};
      pynndescent = self.callPackage ./pynndescent {};
      scanpy = self.callPackage ./scanpy {};
      scvelo = self.callPackage ./scvelo {};
      scvi-tools = self.callPackage ./scvi-tools {};
      session-info = self.callPackage ./session-info {};
      sparse = self.callPackage ./sparse {};
      umap-learn = self.callPackage ./umap-learn {};
      unitvelo = self.callPackage ./unitvelo {};
    });
  };
}
