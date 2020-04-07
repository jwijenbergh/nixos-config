{ pkgs, ... }:
{
  # Import X11 and Polybar
  imports = [
    ../xorg
    ./polybar.nix
    ./scripts
    ./sxhkd.nix
  ];

  # Bspwm settings
  xsession.windowManager.bspwm = {
    enable = true;
    extraConfig = ''
      pkill sxhkd
      sxhkd &
      pkill polybar
      for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar --reload top &
      done
    '';
    monitors = {
      eDP-1 = [ "1" "2" "3" "4" "5" ];
      DP-1 = [ "6" "7" "8" "9" "0" ];
    };
    rules = {
      "emacs" = {
        state = "tiled";
      };
      "scratchterm" = { 
        state = "floating";
        sticky = true;
      };
    };
    settings = {
      # Colors
      normal_border_color = "#282c34";
      active_border_color = "#e06c75";
      focused_border_color = "#e06c75";
      presel_feedback_color = "#98c379";

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
  };

  # Fix Java programs
  pam.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
