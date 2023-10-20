{ R
, rPackages
, fetchzip
, lib
, icu
, pkg-config
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
}) {
  name = "stringi";
  version = "1.7.12";
  src = fetchzip {
    name = "cran-stringi_1.5-8.tar.gz";
    url = "https://cran.r-project.org/src/contrib/stringi_1.7.12.tar.gz";
    sha256 = "sha256-uRLo614wr7qp6Elk3nYF5+glKiYxylDuxRgaRUmojZw=";
  };
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
})
