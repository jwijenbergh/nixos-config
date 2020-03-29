{ pkgs, ... }:

{
  home.packages = [ pkgs.vimPlugins.vim-plug ];

  # Set simple settings
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Neovim config file
  xdg.configFile = {
    "nvim/init.vim".source = ./init.vim;
  };
}
