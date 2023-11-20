final: prev: {
  lib = prev.lib.extend (self: super: {
    packageConfigs = let
      makeOverridableConfigs = f: configs: f configs // {
        overrideConfigs = g: let
          new = self.toFunction g configs;
        in makeOverridableConfigs f new;
      };
      buildChangeList = changes: {
        __functor = self: change: buildChangeList (self.changes ++ [ change ]);

        inherit changes;

        eval = f: makeOverridableConfigs (configs: let
          upd = self.recursiveUpdate;
          config = builtins.head configs;
          res = upd (builtins.foldl' (acc: change: 
            upd acc ((self.toFunction change) (upd acc config))
          ) {} changes) config;
        in f (upd res {
          meta = { inherit configs; };
        }));
      };
    in {
      trivial = buildChangeList [];

      devVersion = {
        PEP440 = conf: let
  	  version = if conf ? devVersion then
            "${conf.devVersion}.dev${builtins.replaceStrings [ "-" ] [ "" ] conf.date}"
 	  else conf.version;
        in {
          inherit version;
          SETUPTOOLS_SCM_PRETEND_VERSION = version;
        };

        R = conf: let
  	  version = if conf ? devVersion then
            "${conf.devVersion}.0.${builtins.replaceStrings [ "-" ] [ "" ] conf.date}"
 	  else conf.version;
        in {
          inherit version;
        };
      };

      resolveLocations = locations: conf: with self.attrsets; {
        sources = mapAttrs (_: s: optionalAttrs (s ? location) (
          locations.${s.location} conf
        )) conf.sources;
        fetchers = mapAttrs (n: _: n) (
          filterAttrs (_: v: (v ? automap) && v.automap) conf.sources
        );
      };

      populateFetchers = deps: conf: let
        sourceFod = v: let
          recipe = conf.sources.${v};
          args = builtins.removeAttrs recipe [
            "method" "automap" "location"
          ];
          func = if builtins.isString recipe.method then
            deps.${recipe.method}
          else
            recipe.method;
        in func args;
      in self.mapAttrs (_: sourceFod) conf.fetchers //
        builtins.removeAttrs conf [ "sources" "fetchers" ];

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
        empty = makeOverridableLocation (conf: {});

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
          urls = let
            base = "https://cran.r-project.org/src/contrib/";
          in with conf; [
            "${base}${pname}_${version}.tar.gz"
            "${base}Archive/${pname}/${pname}_${version}.tar.gz"
          ];
        });
      };
    };
  });
}
