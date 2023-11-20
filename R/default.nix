final: prev: {
  rPackages = prev.rPackages.override (old: {
    overrides = old.overrides // {
      anndata = final.callPackage ./anndata {};
      distances = final.callPackage ./distances {};
      here = final.callPackage ./here {};
      jsonlite = final.callPackage ./jsonlite {};
      markdown = final.callPackage ./markdown {};
      Matrix = final.callPackage ./Matrix {};
      pagoda2 = final.callPackage ./pagoda2 {};
      quadprog = final.callPackage ./quadprog {};
      R6 = final.callPackage ./R6 {};
      rappdirs = final.callPackage ./rappdirs {};
      Rcpp = final.callPackage ./Rcpp {};
      RcppProgress = final.callPackage ./RcppProgress {};
      RcppTOML = final.callPackage ./RcppTOML {};
      reticulate = final.callPackage ./reticulate {};
      rlang = final.callPackage ./rlang {};
      rprojroot = final.callPackage ./rprojroot {};
      stringi = final.callPackage ./stringi {};
      triebeard = final.callPackage ./triebeard {};
      urltools = final.callPackage ./urltools {};
      vctrs = final.callPackage ./vctrs {};
      withr = final.callPackage ./withr {};
    };
  });
}
