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
    mirrors = {
      resolveFetcher = mirrors: info: let
        f = info.fetcher;
      in info // self.optionalAttrs (f ? mirror) {
        fetcher = (self.mirrors // mirrors).${f.mirror} info //
          builtins.removeAttrs f [ "mirror" ];
      };

      generic = name: info: {
        name = "${name}-${info.pname}-${info.version}-source";
      };

      PyPI = info: {
        method = "fetchPypi";
        inherit (info) pname version;
      };
    };
  });
}
