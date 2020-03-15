{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xorg.xrdb
    slurp
    grim
  ];

  # Fix DPI issue
  xresources.properties = {
    "Xft.dpi" = 96;
  };

  # Use firefox-wayland 
  pam.sessionVariables =  {
    MOZ_BACKEND = "1";
  };
}
