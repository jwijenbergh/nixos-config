{ pkgs, config, ... }:

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

    # Base packages
    home.packages = with pkgs; [
      # Dev
      idea.idea-community

      # Fonts
      font-awesome_4
      iosevka
      powerline-fonts

      # Messaging
      discord
      signal-desktop
      teamspeak_client

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
