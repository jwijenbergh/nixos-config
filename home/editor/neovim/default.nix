{ pkgs, ... }:

let 
  unstable = import <nixpkgs-unstable> {};
in
  {
    home.packages = with pkgs; [ vimPlugins.vim-plug ];

    # Set simple settings
    programs.neovim = {
      enable = true;
      package = unstable.neovim;
      viAlias = true;
      vimAlias = true;
    };

    # Neovim config file
    xdg.configFile = {
      "nvim/init.vim".source = ./init.vim;
    };
  }
