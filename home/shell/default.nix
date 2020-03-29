{ pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
  {
    # Set shell packages
    home.packages = with pkgs; [ 
      unstable.any-nix-shell
      bat
      exa
      gotop
      nnn
      ripgrep
      tealdeer
    ];

    # Shell + associated packages that need some configuration
    programs = {
      fish = {
        enable = true;
        shellAbbrs = {
          ls = "exa -l";
          ll = "exa -al";
          f = "nnn";
        };
        promptInit = ''
          any-nix-shell fish | source
        '';
        shellInit = ''
          set -gx EDITOR nvim
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
