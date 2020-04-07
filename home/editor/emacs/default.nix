{ pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
{
  # Set emacs packages
  programs.emacs = {
    enable = true;
    package = unstable.emacs;
    extraPackages = epkgs: with epkgs; [
      company
      company-nixos-options
      counsel
      dracula-theme
      evil
      evil-collection
      evil-magit
      fzf
      htmlize
      nix-mode
      magit
      org-bullets
      rust-mode
      telephone-line
      use-package
      which-key
    ];
  };

  # Enable emacs daemon
  services.emacs.enable = true;

  # Emacs config file
  home.file.".emacs.d/init.el".source = ./init.el;
}
