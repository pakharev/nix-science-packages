final: prev: {
  python = prev.python310.override {
    packageOverrides = (self: super: {
      array-api-compat = self.callPackage ./array-api-compat {};
      numpy-groupies = self.callPackage ./numpy-groupies {};
      get-annotations = self.callPackage ./get-annotations {};
      session-info = self.callPackage ./session-info {};
      anndata = self.callPackage ./anndata {};
      mudata = self.callPackage ./mudata {};
      loompy = self.callPackage ./loompy {};
      scanpy = self.callPackage ./scanpy {};
      scvi-tools = self.callPackage ./scvi-tools {};
      scvelo = self.callPackage ./scvelo {};
      unitvelo = self.callPackage ./unitvelo {};
      iprogress = self.callPackage ./iprogress {};
      flax = self.callPackage ./flax {};

      tensorflow = self.tensorflow-bin;
      umap-learn = super.umap-learn.overrideAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      });
      jax = super.jax.overrideAttrs (old: {
        doCheck = false; 
        doInstallCheck = false;
	propagatedBuildInputs = old.propagatedBuildInputs ++ [ self.jaxlib ];
      });
      torch = super.torch.overrideAttrs (old: {
        doCheck = false; 
        doInstallCheck = false;
      });
      pyflakes = super.pyflakes.overrideAttrs (old: {
        doCheck = false; 
        doInstallCheck = false;
      });
      natsort = super.natsort.overrideAttrs (old: {
        doCheck = false; 
        doInstallCheck = false;
      });
      boto = super.boto.overrideAttrs (old: {
        doCheck = false; 
        doInstallCheck = false;
      });
      pynndescent = super.pynndescent.overrideAttrs (old: {
        doCheck = false; 
        doInstallCheck = false;
      });
    });
  };
}
