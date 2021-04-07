{ pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { overlays = [(import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/d9530a7048f4b1c0f65825202a0ce1d111a1d39a.tar.gz;}))];};
in
{
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    (pkgs.writeScriptBin "vterm-wrappers-fzf-rg-preview.sh" (builtins.readFile ./vterm-wrappers-fzf-rg-preview.sh))
  ];
  nixpkgs.overlays = [
	  (import (builtins.fetchTarball {
	url = https://github.com/nix-community/emacs-overlay/archive/d9530a7048f4b1c0f65825202a0ce1d111a1d39a.tar.gz;
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
