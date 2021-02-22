{ pkgs, lib, ...}:
let
  theme = (import ../../env.nix).theme;
in
{
  imports = [ ../../xorg ./scripts ./polybar.nix ];

  nixpkgs.overlays = [
    (self: super: {
      herbstluftwm = super.callPackage ./package.nix {};
      lemonbar-xft = super.lemonbar-xft.overrideAttrs (oldAttrs: rec {
        src = super.fetchFromGitHub {
          repo = "lemonbar-xft";
          owner = "drscream";
          rev = "481e12363e2a0fe0ddd2176a8e003392be90ed02";
          sha256 = "0588g37h18lv50h7w8vfbwhvc3iajh7sdr53848spaif99nh3mh4";
        };
      });
    })
  ];

  home.packages = with pkgs; [
    herbstluftwm
    lemonbar-xft
  ];

  xsession.windowManager.command = ''
    ${pkgs.herbstluftwm}/bin/herbstluftwm
  '';

  xdg.configFile = {
    "herbstluftwm/autostart" = {
      source = ./autostart;
      executable = true;
    };
  };

  xresources.extraConfig = ''
    hlwm.unfocusedInnerBorder:       #${theme.background}
    hlwm.unfocusedOuterBorder:       #${theme.background}
    hlwm.focusedInnerBorder:         #${theme.color3}
    hlwm.focusedOuterBorder:         #${theme.background}
  '';
}
