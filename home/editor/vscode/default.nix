{ pkgs, ... }:

let 
  unstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
in
  {
    # Codium with packages
    programs.vscode = {
      enable = true;
      package = unstable.vscodium;
      extensions = with unstable.vscode-extensions; [
        bbenoist.Nix
        vscodevim.vim
        ms-vscode.cpptools
      ];
    };
  }
