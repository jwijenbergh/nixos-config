{ pkgs, ... }:

let
  env = import ../env.nix;
  unstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        src = super.fetchFromGitHub {
          repo = "st";
          owner = "jwijenbergh";
          rev = "eae6778842d02e9fcfc4fb4f9dbe6fc648bc56c1";
          sha256 = "0cyya5bnw4rlx2zwsc1p2dlaiq1iia406lsd5nza5vq6rx77a0dm";
        };
      });
    })
  ];

  home.packages = [ pkgs.st ];

  xresources.extraConfig = ''
      st.font:       ${env.font}:pixelsize=14
      st.foreground: ${env.theme.foreground}
      st.background: ${env.theme.background}
      st.color0:     ${env.theme.color0}
      st.color8:     ${env.theme.color8}
      st.color1:     ${env.theme.color1}
      st.color9:     ${env.theme.color9}
      st.color2:     ${env.theme.color2}
      st.color10:    ${env.theme.color10}
      st.color3:     ${env.theme.color3}
      st.color11:    ${env.theme.color11}
      st.color4:     ${env.theme.color4}
      st.color12:    ${env.theme.color12}
      st.color5:     ${env.theme.color5}
      st.color13:    ${env.theme.color13}
      st.color6:     ${env.theme.color6}
      st.color14:    ${env.theme.color14}
      st.color7:     ${env.theme.color7}
      st.color15:    ${env.theme.color15}
  '';
}
