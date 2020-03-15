{
  services.sxhkd = {
    enable = true;
    extraPath = "/run/wrappers/bin:/run/current-system/sw/bin";
    keybindings = {
      "super + Return" = "st -e fish";
      "super + Escape" = "pkill -USR1 -x sxhkd";
      "XF86MonBrightnessUp" = "light -A 10";
      "XF86MonBrightnessDown" = "light -U 10";
      "XF86AudioRaiseVolume" = "pulsemixer --change-volume +5";
      "XF86AudioLowerVolume" = "pulsemixer --change-volume -5";
      "XF86AudioMute" = "pulsemixer --toggle-mute";
      "super + @space" = "rofi -show run";
      "super + alt + Escape" = "bspc quit";
      "super + {_,shift + }w" = "bspc node -c";
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      "super + m" = "bspc desktop -l next";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + {_,shift + }{h,j,k,l}" = "bspc node --{focus,swap} {west,south,north,east}";
      "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
    };
  };

  pam.sessionVariables = { 
    SXHKD_SHELL = "/bin/sh";
  };
}
