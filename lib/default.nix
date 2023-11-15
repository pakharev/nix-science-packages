final: prev: {
  fetchSource = fetcher: let
    inherit (fetcher) method;
    args = builtins.removeAttrs fetcher [ "method" ];
    func = if (builtins.isString method) then (
      if method == "fetchPypi" then
        final.python.pkgs.${method}
      else
        prev.${method}
    ) else method;
  in func args;

  lib = prev.lib.extend (self: super: {
    versionFromDev = r: if r ? devVersion then
      let
        numDate = "${builtins.replaceStrings [ "-" ] [ "" ] r.date}";
        versions = {
          common = "${r.devVersion}.${numDate}";
          python = "${r.devVersion}-dev${numDate}";
        };
        version = if ((r ? platform) && (builtins.hasAttr r.platform versions)) then
          versions.${r.platform}
        else
          versions.common;
      in { inherit version; } // r
    else r;

    automapResources = r: with self; recursiveUpdate {
      fetchers = mapAttrs (n: _: n) (
        filterAttrs (_: v: (v ? automap) && v.automap) r.resources
      );
    } r;

    mirrors = {
      resolve = args: mirrors: r: self.mapAttrs (_: v: let
        res = r.resources.${v};
        recipe = self.optionalAttrs (res ? mirror) (mirrors.${res.mirror} r) //
          builtins.removeAttrs res [ "mirror" ];
        fetchArgs = builtins.removeAttrs recipe [ "method" ];
        fetchFunc = if builtins.isString recipe.method then
          args.${recipe.method}
        else
          recipe.method;
      in fetchFunc fetchArgs) r.fetchers // r;

      resolveFetcher = mirrors: info: let
        f = info.fetcher;
      in info // self.optionalAttrs (f ? mirror) {
        fetcher = (self.mirrors // mirrors).${f.mirror} info //
          builtins.removeAttrs f [ "mirror" ];
      };

      generic = name: r: {
        name = "${name}-${r.pname}-${r.version}-source";
      };

      PyPI = r: {
        method = "fetchPypi";
        inherit (r) pname version;
      };

      CRAN = r: self.mirrors.generic "CRAN" r // {
        method = "fetchzip";
        urls = with r; [
          "https://cran.r-project.org/src/contrib/${pname}_${version}.tar.gz"
          "https://cran.r-project.org/src/contrib/Archive/${pname}/${pname}_${version}.tar.gz"
        ];
      };
    };
  });
}
