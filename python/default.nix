final: prev: {
  python = prev.python310.override {
    packageOverrides = (self: super: {
      array-api-compat = self.callPackage ./array-api-compat {};
      anndata = self.callPackage ./anndata {};
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
    });
  };
}
