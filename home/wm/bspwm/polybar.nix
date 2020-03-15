let
  theme = (import ../../themes/default.nix).current;
in
  {
    services.polybar = {
      enable = true;
      config = {
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
          font-0 = "Hack:pixelsize=12;1";
          font-1 = "FontAwesome:pixelsize=10;1";
          modules-left = "bspwm";
          modules-right = "battery date tray-label";
          tray-offset-x = 0;
          tray-position = "right";
          tray-padding = 1;
          tray-background = "${theme.color2}";
          wm-restack = "bspwm";
        };

        "module/bspwm" = {
          type = "internal/bspwm";
          ws-icon-0 = "term;";
          ws-icon-1 = "code;";
          ws-icon-2 = "web;";
          ws-icon-3 = "music;";
          ws-icon-4 = "chat;";
          ws-icon-5 = "other;";
          ws-icon-default = "";

          format = "<label-state> <label-mode>";

          label-focused = "%icon%";
          label-focused-background = "${theme.color1}";
          label-focused-underline= "${theme.color1}";
          label-focused-padding = 1;

          label-occupied = "%icon%";
          label-occupied-background = "${theme.color2}";
          label-occupied-underline = "${theme.color1}";
          label-occupied-padding = 1;

          label-urgent = "%icon%!";
          label-urgent-background = "${theme.color2}";
          label-urgent-underline = "${theme.color1}";
          label-urgent-padding = 1;

          label-empty = "%icon%";
          label-empty-background = "${theme.color2}";
          label-empty-underline = "${theme.color2}";
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
          format-charging-background = "${theme.color1}";
          format-charging-padding = 1;
          format-discharging-background = "${theme.color1}";
          format-discharging-padding = 1;

          label-charging = "%percentage%%";
          label-charging-background = "${theme.color1}";
          label-charging-padding = 1;
          label-discharging = "%percentage%%";
          label-discharging-background = "${theme.color2}";
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
          format-background = "${theme.color1}";
          label-background = "${theme.color2}";
          label-padding = 1;
        };

        "module/tray-label" = {
          type = "custom/text";
          content = "";
          content-background = "${theme.color1}";
          content-padding = 1;
        };
      };
      script = "polybar top &";
    };
  }
