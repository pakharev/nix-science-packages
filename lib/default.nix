final: prev: {
  lib = prev.lib.extend (self: super: {
    configurablePackages = let
      makeOverridableConfigs = f: configs: f configs // {
        overrideConfigs = g: let
          new = self.toFunction g configs;
        in makeOverridableConfigs f new;
      };
    in {
      inherit makeOverridableConfigs;

      style = {
        versionFromDev = devVersion: numDate: "${devVersion}.dev${numDate}";
        gitRev = version: "refs/tags/v${version}";
      };

      versionFromDev = conf: self.optionalAttrs (conf ? devVersion) { 
        version = let
          numDate = "${builtins.replaceStrings [ "-" ] [ "" ] conf.date}";
          inherit (self.configurablePackages.style) versionFromDev;
        in versionFromDev conf.devVersion numDate;
      } // conf;

      resolveFetchers = {
        deps, locations
      }: conf: with self.attrsets; let
        sources = mapAttrs (_: s: optionalAttrs (s ? location) (
          locations.${s.location} conf
        )) conf.sources;
        fetchers = mapAttrs (n: _: n) (
          filterAttrs (_: v: (v ? automap) && v.automap) conf.sources
        );
        resolvedConfig = recursiveUpdate {
          inherit sources fetchers;
        } conf;
        sourceFod = v: let
          recipe = resolvedConfig.sources.${v};
          args = builtins.removeAttrs recipe [
            "method" "automap" "location"
          ];
          func = if builtins.isString recipe.method then
            deps.${recipe.method}
          else
            recipe.method;
        in func args;
	fods = mapAttrs (_: sourceFod) resolvedConfig.fetchers;
      in recursiveUpdate (fods // resolvedConfig) {
        meta = { inherit resolvedConfig; };
      };

      commonLocations = let
        makeOverridableLocation = f: {
          __functor = _: self.toFunction f;
          override = g: let
            new = conf: self.toFunction f conf // self.toFunction g conf;         
          in makeOverridableLocation new;
        };
        generic = name: makeOverridableLocation (conf: {
          name = "${name}-${conf.pname}-${conf.version}-source";
        });
      in {
        inherit generic;

        GitHub = (generic "GitHub").override (conf: {
          method = "fetchFromGitHub";
          repo = conf.pname;   
          rev = self.configurablePackages.style.gitRev conf.version;
        });

        PyPI = makeOverridableLocation (conf: {
          method = "fetchPypi";
          inherit (conf) pname version;
        });

        CRAN = (generic "CRAN").override (conf: {
          method = "fetchzip";
          urls = with conf; [
            "https://cran.r-project.org/src/contrib/${pname}_${version}.tar.gz"
            "https://cran.r-project.org/src/contrib/Archive/${pname}/${pname}_${version}.tar.gz"
          ];
        });
      };
    };
  });
}
