{ pkgs, ... }:

{
  # Some packages
  home.packages = with pkgs; [
    betterlockscreen
    feh
    flameshot
    rofi
    sxiv
    xclip
    xdotool
  ];

  # Set caps to ctrl
  home.keyboard.options = [ "ctrl:nocaps" ];

  # Always set bg with feh in xorg
  home.file.".xprofile".text = ''
    xrdb -merge $HOME/.cache/wal/st
    xrdb -merge $HOME/.cache/wal/dwm
    xrdb -merge $HOME/.Xresources
    feh --bg-scale $HOME/Pictures/Wallpapers/current.png
    wal -R
  '';

  # 'fixes' screen tearing
  services = {
    compton = {
      enable = true;
      vSync = "opengl-swc";
    };
  };

  # Set home manager to manage the session
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
  };
}
