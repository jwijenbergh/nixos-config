{ pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { overlays = [(import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/0fe62fbeb3e30fe4eb5feefa65b31d509e82c5e8.tar.gz;}))];};
in
{
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    (pkgs.writeScriptBin "vterm-wrappers-fzf-rg-preview.sh" (builtins.readFile ./vterm-wrappers-fzf-rg-preview.sh))
  ];
  nixpkgs.overlays = [
	  (import (builtins.fetchTarball {
	url = https://github.com/nix-community/emacs-overlay/archive/474bafd0d5c59410afcd4d6f95b8e85a6781ff2c.tar.gz;
		   }))
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: with epkgs; [
      bicycle
      dashboard
      deadgrep
      doom-modeline
      doom-themes
      evil
      evil-collection
      evil-easymotion
      evil-magit
      flycheck
      fzf
      general
      haskell-mode
      lua-mode
      magit
      mini-frame
      nix-mode
      org-bullets
      posframe
      rg
      selectrum
      selectrum-prescient
      prescient
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
