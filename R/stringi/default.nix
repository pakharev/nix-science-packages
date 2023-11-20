{ lib
, R
, rPackages
, icu
, pkg-config
, fetchzip
}@deps: with lib.packageConfigs; (trivial

{
  pname = "stringi";
  meta = {
    description = "";
    homepage = "";
    #license = lib.licenses.;
  };
}

devVersion.R

(conf: {
  name = "${conf.pname}-${conf.version}";
  fetchers.src = "srcCRAN";
})

(with commonLocations; resolveLocations {
  inherit CRAN;
})

).eval (conf:
(lib.makeOverridable ({
  name, version, src,
  depends ? [],
  doCheck ? true,
  requireX ? false,
  broken ? false,
  platforms ? R.meta.platforms,
  maintainers ? []
}: rPackages.buildRPackage {
  name = "${name}-${version}";
  inherit src doCheck requireX;
  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;
  meta.platforms = platforms;
  meta.broken = broken;
  meta.maintainers = maintainers;
}) {
  inherit (conf) name version;
  inherit (populateFetchers deps conf) src;
}).overrideDerivation (old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [ icu.dev ];
  buildInputs = old.buildInputs ++ [ pkg-config ];
  postInstall = let
    icuName = "icudt69l";
    icuSrc = fetchzip {
      url = "https://github.com/gagolews/stringi/raw/master/src/icu69/data/icu4c-69_1-data-bin-l.zip";
      sha256 = "sha256-bVdxmqE1n8ahOY0J6egZpRjcqE8TvPyrHSPiMsneD20=";
      stripRoot = false;
    };
  in ''
    ${old.postInstall or ""}
    cp ${icuSrc}/${icuName}.dat $out/library/stringi/libs
  '';
})) (import ./releases.nix)
