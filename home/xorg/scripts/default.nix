{ pkgs, ... }:
{
  # Define scripts to use
  home.packages = [
    (pkgs.writeScriptBin "xget" (builtins.readFile ./xget.sh))
    (pkgs.writeScriptBin "record_gif" (builtins.readFile ./record_gif.sh))
  ];
}
