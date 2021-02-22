let
  theme = (import ../../env.nix).theme;
in
{
  services.polybar = {
    enable = true;
    config = {
      "colors" = {
        background = "${theme.background}";
        color1 = "${theme.color1}";
        color2 = "${theme.color2}";
      };
      "bar/top" = {
        monitor = "\$\{env:MONITOR:eDP-1\}";
        width = 1920;
        height = 24;
        background = "${theme.background}";
        foreground = "${theme.background}";
        line-size = 2;
        line-color = "${theme.background}";
        border-size = 8;
        border-color = "${theme.background}";
        font-0 = "Iosevka:pixelsize=12;3";
        font-1 = "FontAwesome:pixelsize=10;2";
        modules-left = "hlwm";
        modules-right = "battery0 battery1 date tray-label";
        tray-offset-x = 0;
        tray-position = "right";
        tray-padding = 1;
        tray-background = "\$\{colors.color2\}";
        wm-restack = "bspwm";
      };
      
      "module/hlwm" = {
        type = "custom/script";
        exec-if = "ps -C herbstluftwm >/dev/null 2>&1";
        exec = "hlwmtags";
        tail = true;
      };
      
      "module/battery0" = {
        type = "internal/battery";
        full-at = 99;
        battery = "BAT0";
        adapter = "AC";
        poll-interval = 5;
        
        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-charging-background = "\$\{colors.color1\}";
        format-charging-padding = 1;
        format-discharging-background = "\$\{colors.color1\}";
        format-discharging-padding = 1;
        
        label-charging = "%percentage%%";
        label-charging-background = "\$\{colors.color2\}";
        label-charging-padding = 1;
        label-discharging = "%percentage%%";
        label-discharging-background = "\$\{colors.color2\}";
        label-discharging-padding = 1;
        
        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
      };

      "module/battery1" = {
        type = "internal/battery";
        full-at = 99;
        battery = "BAT1";
        adapter = "AC";
        poll-interval = 5;
        
        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-charging-background = "\$\{colors.color1\}";
        format-charging-padding = 1;
        format-discharging-background = "\$\{colors.color1\}";
        format-discharging-padding = 1;
        
        label-charging = "%percentage%%";
        label-charging-background = "\$\{colors.color2\}";
        label-charging-padding = 1;
        label-discharging = "%percentage%%";
        label-discharging-background = "\$\{colors.color2\}";
        label-discharging-padding = 1;
        
        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
      };
      
      "module/date" = {
        type = "internal/date";
        interval = 5;
        
        date = "%m-%d%";
        
        time = "%H:%M";
        
        label = "%time%";
        
        format = " <label>";
        format-padding = 1;
        format-background = "\$\{colors.color1\}";
        label-background = "\$\{colors.color2\}";
        label-padding = 1;
      };
      
      "module/tray-label" = {
        type = "custom/text";
        content = "";
        content-background = "\$\{colors.color1\}";
        content-padding = 1;
      };
    };
    script = "polybar top &";
  };
}
