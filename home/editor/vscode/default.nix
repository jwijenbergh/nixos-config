{ pkgs, ... }:
let 
  unstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
in
{
  imports = [
    "${builtins.fetchGit {
      url = "https://github.com/msteen/nixos-vsliveshare.git";
      ref = "refs/heads/master";
    }}/modules/vsliveshare/home.nix"
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with unstable.vscode-extensions; [
      bbenoist.Nix
      vscodevim.vim
      ms-vscode.cpptools
    ];
  };

  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode-oss/extensions";
    nixpkgsPath = builtins.fetchGit {
      url = "https://github.com/NixOS/nixpkgs.git";
      ref = "refs/heads/nixos-20.03";
      rev = "61cc1f0dc07c2f786e0acfd07444548486f4153b";
    };
  };
}
