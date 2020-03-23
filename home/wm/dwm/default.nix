{ pkgs, ... }:

let
  theme = (import ../themes).current;
in
  {
    home.packages = with pkgs; [

      # Bar
      (
        writeScriptBin "dwmbar" ''
#!/bin/sh

_bat() {
        echo  "$(cat /sys/class/power_supply/BAT0/capacity)"%
}

_date() {
        echo  "$(date '+%H:%M - %d %B')"
}

_vol() {
        echo  "$(pulsemixer --get-volume | awk '{print $1}')"
}

trap 'echo "SIGUSR1, reloading...."' USR1

while :
do
        xsetroot -name " $(_bat)  $(_vol)  $(_date)"
        sleep 60 &
        wait $!
done
        ''
      )

      # Refresh Bar
      (
        writeScriptBin "refdwmbar" ''
#!/bin/sh

pkill -SIGUSR1 dwmbar
        ''
      )

      # Packages
      dwm
      dmenu
    ];

    imports = [ ../../server/x11.nix ];

    nixpkgs.overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: rec {
          src = super.fetchFromGitHub {
            repo = "dwm";
            owner = "jwijenbergh";
            rev = "751059b11654ca9d224d765fb53af08c4e7afcbc";
            sha256 = "06fvb59wfrs2qcqkvh8g98x2rhgldp702f9ln8j45n1g8j8659x2";
          };
        });
      })
    ];


    home.file.".xprofile".text = ''
      feh --bg-scale "$HOME/Pictures/Wallpapers/current.png"
      dwmbar &
    '';

    xsession.windowManager.command = ''
      while true; do
        ${pkgs.dwm}/bin/dwm >/dev/null 2>&1
      done
    '';

    pam.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  }
