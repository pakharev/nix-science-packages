{ writeShellApplication
}: 
writeShellApplication { 
  name = "patchShebangs";
  text = builtins.readFile ./patch-shebangs.sh;
}
