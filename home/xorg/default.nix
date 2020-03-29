{ pkgs, ... }:

{
  # Some packages
  home.packages = with pkgs; [
    betterlockscreen
    feh
    flameshot
    sxiv
    xclip 
  ];

  # Set caps to ctrl
  home.keyboard.options = [ "ctrl:nocaps" ];

  # Always set bg with feg in xorg
  home.file.".xprofile".text = ''
    feh --bg-scale $HOME/Pictures/Wallpapers/current.png
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
