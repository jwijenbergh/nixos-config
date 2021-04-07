{ pkgs, ... }:
let
  theme = (import ../../env.nix).theme;
in
{
  imports = [ ../../xorg ];

  nixpkgs.overlays = [
    (self: super: {
      eww = super.callPackage ./eww.nix {};
    })
  ];

  home.packages = with pkgs; [ qtile eww ];

  xsession.windowManager.command = ''
    while true; do
      ${pkgs.qtile}/bin/qtile >/dev/null 2>&1
    done
    '';

  pam.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  xdg.configFile = {
    "qtile/config.py".source = ./config.py;
    "qtile/wmenv.py".text = ''
colors = {
   "bar-bg": "${theme.background}",
   "bar-fg": "${theme.foreground}",
   "bar-accent": "${theme.color3}",
   "bar-widget-pomodoro": "${theme.color9}",
   "bar-widget-time": "${theme.color10}",
   "bar-widget-pin": "${theme.color13}",
   "bar-widget-bat": "${theme.color14}",
   "bar-widget-group-active": "${theme.foreground}",
   "bar-widget-group-inactive": "${theme.foreground}",
   "bar-widget-group-focused": "${theme.foreground}",
   "bar-widget-group-focused-othermon": "${theme.foreground}",
   "border-focus": "${theme.color3}",
   "border-normal": "${theme.foreground}",
}'';
    "qtile/autostart.sh" = {
      executable = true;
      text = ''
#!/bin/sh
#eww daemon &
#sleep 3
#eww open bar-bottom &
feh --bg-scale ~/Pictures/Wallpapers/current.webp &
    '';
    };
  };
}
