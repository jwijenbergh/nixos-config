{ pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { overlays = [(import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/26f0a5e1d1f3934f0d6596b2c411dba52e6d7211.tar.gz;}))];};
in
{
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    (pkgs.writeScriptBin "vterm-wrappers-fzf-rg-preview.sh" (builtins.readFile ./vterm-wrappers-fzf-rg-preview.sh))
  ];
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/26f0a5e1d1f3934f0d6596b2c411dba52e6d7211.tar.gz;
    }))
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: with epkgs; [
      auctex
      bicycle
      dashboard
      deadgrep
      doom-modeline
      doom-themes
      evil
      evil-collection
      evil-easymotion
      flycheck
      fzf
      general
      haskell-mode
      highlight-indent-guides
      lua-mode
      magit
      mini-frame
      nix-mode
      org-bullets
      posframe
      rainbow-delimiters
      rg
      selectrum
      orderless
      consult
      use-package
      vterm
      with-editor
      which-key
      transient
    ];
  };

  home.file.".emacs.d/init.el".source = ./init.el;
  home.file.".emacs.d/early-init.el".source = ./early-init.el;

  # Enable emacs daemon
  services.emacs.enable = true;
}
