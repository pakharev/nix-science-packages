{
  fetchSource = self: info: let
    fetcher = builtins.head info.fetchers;
    inherit (fetcher) method;
    args = builtins.removeAttrs fetcher [ "method" ];
  in if builtins.isString method then
    self.${method} args
  else
    method args;

  chooseSource = pred: file: if pred ? fetchers then pred
    else let
      p = if builtins.isFunction pred then pred 
        else info: builtins.all (n: (info ? ${n}) && (info.${n} == pred.${n})) (builtins.attrNames pred);
      infos = builtins.fromJSON (builtins.readFile file);
      validInfos = builtins.filter p infos;
    in if validInfos == []
      then throw "no source"
      else builtins.head validInfos;
}
