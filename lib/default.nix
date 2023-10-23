{
  fetchSource = self: info: let
    inherit (info) fetcher;
    inherit (fetcher) method;
    args = builtins.removeAttrs fetcher [ "method" ];
  in if builtins.isString method then
    self.${method} args
  else
    method args;
}
