{ lib
, R
, rPackages
, icu
, pkg-config
, fetchSource
, allReleases ? import ./releases.nix
, release ? builtins.head allReleases
, info ? (import ./info.nix) lib release
}: 
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
}) (with info; {
  name = "${pname}-${version}";
  inherit version;
  src = fetchSource fetcher;
})).overrideDerivation (old: {
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
})
