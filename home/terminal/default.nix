{ pkgs, ... }:

let
  theme = (import ../themes).current;
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
      st.foreground: ${theme.foreground}
      st.background: ${theme.background}
      st.color0: ${theme.color0}
      st.color8: ${theme.color8}
      st.color1: ${theme.color1}
      st.color9: ${theme.color9}
      st.color2: ${theme.color2}
      st.color10: ${theme.color10}
      st.color3: ${theme.color3}
      st.color11: ${theme.color11}
      st.color4: ${theme.color4}
      st.color12: ${theme.color12}
      st.color5: ${theme.color5}
      st.color13: ${theme.color13}
      st.color6: ${theme.color6}
      st.color14: ${theme.color14}
      st.color7: ${theme.color7}
      st.color15: ${theme.color15}
  '';
}
