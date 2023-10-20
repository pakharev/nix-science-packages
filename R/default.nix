final: prev: {
  fetchSource = (import ../lib).fetchSource final;

  rPackages = prev.rPackages.override (old: {
    overrides = old.overrides // {
      reticulate = final.callPackage ./reticulate {};
      anndata = final.callPackage ./anndata {};
      rappdirs = final.callPackage ./rappdirs {};
      R6 = final.callPackage ./R6 {};
      Matrix = final.callPackage ./Matrix {};
      Rcpp = final.callPackage ./Rcpp {};
      RcppTOML = final.callPackage ./RcppTOML {};
      here = final.callPackage ./here {};
      jsonlite = final.callPackage ./jsonlite {};
      rlang = final.callPackage ./rlang {};
      withr = final.callPackage ./withr {};
      rprojroot = final.callPackage ./rprojroot {};
      distances = final.callPackage ./distances {};
      quadprog = final.callPackage ./quadprog {};
      pagoda2 = final.callPackage ./pagoda2 {};
      RcppProgress = final.callPackage ./RcppProgress {};
      urltools = final.callPackage ./urltools {};
      triebeard = final.callPackage ./triebeard {};
      stringi = final.callPackage ./stringi {};
    };
  });
}
