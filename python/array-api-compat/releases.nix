(builtins.concatMap (r: map (m: r // { 
  mirror = m;
  fetcher = r.mirrors.${m};
}) (builtins.attrNames r.mirrors)) [
  {
    date = "2023-09-14";
    version = "1.4";
    type = "minor";
    mirrors = {
      pypi = {
        hash = "sha256-1J8A62a0Ns86YCbW9DwRXT4FijqZNlNrC6wz3UcOi00=";
      };
    };
  }
]) ++ (map (r: r // { 
  type = "dev"; 
  mirror = "dev";
  version = "${r.version}-dev${builtins.replaceStrings [ "-" ] [ "" ] r.date}";
}) [
])
