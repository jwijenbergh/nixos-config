{ pkgs, ... }:

{
  # Set emacs packages
  programs.emacs = {
    enable = true;
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

  # Emacs config file
  home.file.".emacs.d/init.el".source = ./init.el;
}
