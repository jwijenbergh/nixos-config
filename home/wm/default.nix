{ pkgs, ... }:

{
  # Scripts and packages
  home.packages = with pkgs; [
    # Scripts
    (writeScriptBin "dwmbar" (builtins.readFile ./scripts/dwmbar))
    (writeScriptBin "refdwmbar" (builtins.readFile ./scripts/refdwmbar))

    # Packages
    dmenu
    dwm
  ];

  # We need xorg
  imports = [ ../xorg ];

  # Use my own dwm build
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        src = /home/jerry/Repos/dwm;
      });
    })
  ];

  # Start bar in .xprofile
  home.file.".xprofile".text = ''
    dwmbar &
  '';

  # Pywal template
  xdg.configFile = 
  {
    "wal/templates/dwm".text = ''
       dwm.normbordercolor: {color4}
       dwm.normbgcolor:     {background}
       dwm.normfgcolor:     {foreground}
       dwm.selbordercolor:  {color1}
       dwm.selbgcolor:      {color1}
       dwm.selfgcolor:      {background}
    '';
  };

  # Run dwm in a loop
  xsession.windowManager.command = ''
    while true; do
      ${pkgs.dwm}/bin/dwm >/dev/null 2>&1
    done
  '';

  # Fix java programs
  pam.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
