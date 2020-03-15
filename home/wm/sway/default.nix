{ pkgs, ... }:
{
  imports = [ ../../server/wayland.nix
              ./waybarstyle.nix ];

  # Sway .config files
  xdg.configFile = {
    "sway/config".source = ./sway;
    "waybar/config".source = ./waybar;
  };

  # Fix Java programs
  pam.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
