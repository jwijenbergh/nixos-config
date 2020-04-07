{ pkgs, lib, config, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
  {
    # Allow unfree
    nixpkgs.config.allowUnfree = true;

    # Various modules with other packages and associated configuration
    imports = [
      ./editor # Neovim and vscode config
      ./shell # Shell with utilities
      ./terminal # St
      ./wm # Dwm
    ];

    # Let home manager manage fontconfig
    fonts.fontconfig.enable = lib.mkForce true;

    # Base packages
    home.packages = with pkgs; [
      # Fonts
      iosevka
      font-awesome_4

      # Messaging
      discord
      signal-desktop
      teamspeak_client

      # Uni
      anki
      texlive.combined.scheme-full

      # Other
      firefox
      mpv
      pulsemixer
      pywal
      shadowfox
      spotify
      zathura

      # Unstable packages
      unstable.bitwarden-cli
      unstable.pfetch
      unstable.protonmail-bridge
      unstable.ueberzug
    ];

    # Enable home manager
    programs.home-manager.enable = true;

    # Manage .config
    xdg.enable = true;
  }
