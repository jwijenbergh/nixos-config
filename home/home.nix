{ pkgs, config, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
{
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Various modules with other packages
  imports = [
    ./editor # Emacs and Neovim config
    ./shell # Shell with utilities
    ./terminal # Termite
    ./wm # Dwm
  ];

  # Base packages
  home.packages = with pkgs; [
    discord
    exa
    firefox
    font-awesome_4
    hack-font
    htop
    mpv
    neofetch
    pass
    pulsemixer
    powerline-fonts
    shadowfox
    signal-desktop
    spotify
    teamspeak_client
    vscodium
    zathura
    unstable.bitwarden-cli
    unstable.protonmail-bridge
  ];

  # Enable home manager
  programs.home-manager.enable = true;

  # Manage .config
  xdg.enable = true;
}
