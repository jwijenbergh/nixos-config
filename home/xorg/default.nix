{ pkgs, ... }:
let
  theme = (import ../env.nix).theme;
in
{
  imports = [ ./scripts ];

  # Some packages
  home.packages = with pkgs; [
    betterlockscreen
    feh
    flameshot
    rofi
    sxiv
    xclip
    xdotool
    xorg.appres
  ];

  # Set caps to ctrl
  home.keyboard.options = [ "ctrl:nocaps" ];

  # Always set bg with feh in xorg
  home.file.".xprofile".text = ''
    xrdb -merge $HOME/.Xresources
    feh --bg-scale $HOME/Pictures/Wallpapers/current.jpg
  '';

  # 'fixes' screen tearing
  services = {
    picom = {
      enable = true;
      vSync = true;
      # See https://github.com/yshui/picom/issues/401
      extraOptions = ''
        use-damage = false;
        unredir-if-possible = true;
      '';
    };
  };

  xresources.extraConfig = ''
    *.foreground:       #${theme.foreground}
    *.background:       #${theme.background}
    *.color0:           #${theme.background}
    *.color8:           #${theme.color8}
    *.color1:           #${theme.color1}
    *.color9:           #${theme.color9}
    *.color2:           #${theme.color2}
    *.color10:          #${theme.color10}
    *.color3:           #${theme.color3}
    *.color11:          #${theme.color11}
    *.color4:           #${theme.color4}
    *.color12:          #${theme.color12}
    *.color5:           #${theme.color5}
    *.color13:          #${theme.color13}
    *.color6:           #${theme.color6}
    *.color14:          #${theme.color14}
    *.color7:           #${theme.color7}
    *.color15:          #${theme.color15}
  '';

  # Set home manager to manage the session
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
  };
}
