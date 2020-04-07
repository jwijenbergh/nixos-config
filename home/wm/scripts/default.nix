{ pkgs, ... }:
{
  # Define scripts to use
  home.packages = [
    (pkgs.writeScriptBin "scratchtoggle" (builtins.readFile ./scratchtoggle))
  ];
}
