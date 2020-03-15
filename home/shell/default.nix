{ pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
{
  # Set shell packages
  home.packages = with pkgs; [ unstable.any-nix-shell exa gotop ripgrep tealdeer ];

  # Shell packages that need some configuration
  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        ls = "exa -l";
        ll = "exa -al";
        vifm = "vifm .";
        f = "vifm .";
      };
      promptInit = ''
        any-nix-shell fish | source
      '';
      shellInit = ''
        function fish_greeting; end
        set -U fish_prompt_pwd_dir_length 0
      '';
    };
    fzf = {
      enable = true;
      defaultCommand = "rg --files --hidden";
    };
    git = {
      enable = true;
      userName = "Jeroen Wijenbergh";
      userEmail = "jeroenwijenbergh@protonmail.com";
    };
  };
}
