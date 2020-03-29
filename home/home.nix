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
      discord
      exa
      firefox
      font-awesome_4
      htop
      idea.idea-community
      iosevka
      mpv
      pass
      pulsemixer
      powerline-fonts
      python37Packages.pywal
      shadowfox
      signal-desktop
      spotify
      teamspeak_client
      zathura

      # Some unstable packages
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
