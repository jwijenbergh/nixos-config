{ pkgs, ... }:
let
  theme = (import ../env.nix).theme;
in
{
  # Use my own st build
  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        src = /home/jerry/Repos/st;
      });
    })
  ];

  # Install it
  home.packages = [ pkgs.st ];

  # Pywal template
  xdg.configFile = 
  {
    "wal/templates/st".text = ''
    '';
  };

  xresources.extraConfig = ''
    st.font: Iosevka:pixelsize=18
  '';
}
