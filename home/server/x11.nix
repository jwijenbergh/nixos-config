{ pkgs, ... }:
let 
  unstable = import <nixpkgs-unstable> {};
in
{
  home.packages = with pkgs; [ betterlockscreen feh flameshot xss-lock ];

  home.keyboard.options = [ "ctrl:nocaps" ];

  programs = {
    autorandr = {
      enable = true;
    };
    rofi = {
      enable = true;
      terminal = "${pkgs.st}/bin/st";
      theme = "gruvbox-dark";
    };
  };

  services = {
    compton = {
      enable = true;
      vSync = "opengl-swc";
	};
	screen-locker = {
      enable = true;
	  inactiveInterval = 10;
      lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock blur";
	};
  };

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
  };
}
