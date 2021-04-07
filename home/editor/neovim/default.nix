{ pkgs, ... }:
let 
  unstable = import <nixos-unstable> {};
in
  {
    home.packages = with pkgs; [ tree-sitter gcc ];
    nixpkgs.overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      }))
    ];
  # Set simple settings
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
  };

  # Neovim config file
  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
  };
}
