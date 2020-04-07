{
  services.polybar = {
    enable = true;
    config = {
      "colors" = {
        background = "\$\{xrdb:background\}";
        color1 = "\$\{xrdb:color1\}";
        color2 = "\$\{xrdb:color2\}";
      };
      "bar/top" = {
        monitor = "\$\{env:MONITOR:eDP-1\}";
        width = 1920;
        height = 24;
        background = "\$\{colors.background\}";
        foreground = "\$\{colors.background\}";
        line-size = 2;
        line-color = "\$\{colors.background\}";
        border-size = 8;
        border-color = "\$\{colors.background\}";
        font-0 = "Iosevka:pixelsize=12;3";
        font-1 = "FontAwesome:pixelsize=10;2";
        modules-left = "bspwm";
        modules-right = "battery date tray-label";
        tray-offset-x = 0;
        tray-position = "right";
        tray-padding = 1;
        tray-background = "\$\{colors.color2\}";
        wm-restack = "bspwm";
      };
  
      "module/bspwm" = {
        type = "internal/bspwm";
        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;";
        ws-icon-3 = "4;";
        ws-icon-4 = "5;";
        ws-icon-5 = "6;";
        ws-icon-6 = "7;";
        ws-icon-7 = "8;";
        ws-icon-8 = "9;";
        ws-icon-9 = "0;";
        ws-icon-default = "";
  
        format = "<label-state> <label-mode>";
  
        label-focused = "%name% %icon%";
        label-focused-background = "\$\{colors.color1\}";
        label-focused-underline= "\$\{colors.color1\}";
        label-focused-padding = 1;
  
        label-occupied = "%name% %icon%";
        label-occupied-background = "\$\{colors.color2\}";
        label-occupied-underline = "\$\{colors.color1\}";
        label-occupied-padding = 1;
  
        label-urgent = "%name% %icon%!";
        label-urgent-background = "\$\{colors.color2\}";
        label-urgent-underline = "\$\{colors.color1\}";
        label-urgent-padding = 1;
  
        label-empty = "%name% %icon%";
        label-empty-background = "\$\{colors.color2\}";
        label-empty-underline = "\$\{colors.color2\}";
        label-empty-padding = 1;
  
        label-separator = " ";
        label-separator-padding = 0;
      };
  
      "module/battery" = {
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
