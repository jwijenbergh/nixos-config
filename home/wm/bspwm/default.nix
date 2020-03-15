{ pkgs, ... }:
let
  theme = (import ../../themes/default.nix).current;
in
{
  # Import X11 and Polybar
  imports = [ ../../server/x11.nix
              ./polybar.nix
              ./sxhkd.nix ];

  # Bspwm settings
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      eDP-1 = [ "term" "code" "web" "music" "chat" "other" ];
      DP-1 = [ "term" "code" "web" "music" "chat" "other" ];
    };
    settings = {
      # Colors
      normal_border_color = "${theme.color0}";
      active_border_color = "${theme.color1}";
      focused_border_color = "${theme.color1}";
      presel_feedback_color = "${theme.color2}";

      # Monitor settings
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;

      # Other
      border_width = 2;
      window_gap = 10;
      automatic_scheme = "alternate";
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;
    };
    startupPrograms = [ "feh --bg-scale \"$HOME/Pictures/Wallpapers/current.png\"" ];
  };

  # Fix Java programs
  pam.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
