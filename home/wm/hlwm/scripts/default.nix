{ pkgs, ... }:
{
  # Define scripts to use
  home.packages = [
    (pkgs.writeScriptBin "hlwmbar" (builtins.readFile ./hlwmbar.sh))
    (pkgs.writeScriptBin "hlwmtags" (builtins.readFile ./hlwmtags.sh))
    (pkgs.writeScriptBin "hlwmtoggleframe" (builtins.readFile ./hlwmtoggleframe.sh))
  ];
}
