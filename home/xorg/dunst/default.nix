{ pkgs, ... }:
let
  theme = (import ../../env.nix).theme;
in
{
  home.packages = with pkgs; [ libnotify ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "500x5-30+70";
        frame_width = 3;
        frame_color = "#${theme.color3}";
        format = ''<b>%a: %s</b>\n%b'';
        padding = 10;
        horizontal_padding = 12;
        font = "Iosevka Nerd Font 14";
        notification_height = 90;
      };
      urgency_low = {
        background = "#${theme.background}";
        foreground = "#${theme.foreground}";
        frame_color = "#${theme.color3}";
        timeout = 10;
      };
      urgency_normal = {
        background = "#${theme.background}";
        foreground = "#${theme.foreground}";
        frame_color = "#${theme.color3}";
        timeout = 10;
      };
      urgency_critical = {
        background = "#${theme.background}";
        foreground = "#${theme.foreground}";
        frame_color = "#${theme.color3}";
        timeout = 10;
      };
    };
  };
}
