{ pkgs, lib, config, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Various modules with other packages and associated configuration
  imports = [
    ./editor # Emacs config
    ./shell # Shell with utilities
    ./terminal # St
    ./wm/qtile # wm
  ];

  nixpkgs.overlays = [
    (self: super: {
      doh-proxy = super.doh-proxy.overrideAttrs (oldAttrs: rec {
        src = "/home/jerry/Repos/doh-proxy";
        dontUnpack = true;
      });
    })
  ];

  # Let home manager manage fontconfig
  fonts.fontconfig.enable = lib.mkForce true;

  # Base packages
  home.packages = with pkgs; [
#    doh-proxy

    # Fonts
    noto-fonts
    (nerdfonts.override { fonts = [ "Iosevka" ]; }) 

    # Messaging
    discord
    signal-desktop
    teamspeak_client

    # Uni
    anki
    texlive.combined.scheme-full
    unstable.jabref

    # Other
    mpv
    pulsemixer
    pywal
    spotify
    zathura

    teams

    bitwarden
    bitwarden-cli
    protonmail-bridge
    ueberzug

    skype
    steam

    vscodium
    unstable.ledger-live-desktop
  ];

  programs.firefox = {
    enable = true;
    profiles = {
      jerry = {
        userChrome = ''
#tabbrowser-tabpanels {
  background: var(--toolbar-bgcolor) !important;
}
        '';
        userContent = ''
@-moz-document url-prefix(about:blank) {*{background-color:#333333;}}
        '';
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };

  services.network-manager-applet.enable = true;

  # Enable home manager
  programs.home-manager.enable = true;

  # Manage .config
  xdg.enable = true;
}
