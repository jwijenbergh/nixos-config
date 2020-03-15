let
  theme = (import ../../themes/default.nix).current;
in
{
  xdg.configFile."waybar/style.css".text = ''
* {
    border: none;
    border-radius: 0;
    font-family: Hack;
    font-size: 15px;
  min-height: 0;
}

window#waybar {
    background: ${theme.background};
}

#workspaces button {
    padding: 0 5px;
    background: transparent;
    color: ${theme.foreground};
    border-bottom: 3px solid transparent;
}

#workspaces button.focused {
    background: ${theme.foreground};
  color: ${theme.background};
    border-bottom: 3px solid white;
}

#mode, #clock, #battery {
    padding: 0 10px;
}

#mode {
    background: #64727D;
    border-bottom: 3px solid white;
}

#clock {
    background-color: #64727D;
}

#battery {
    background-color: #ffffff;
    color: black;
}

#battery.charging {
    color: white;
    background-color: #26A65B;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: black;
    }
}

#battery.warning:not(.charging) {
    background: #f53c3c;
    color: white;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}
'';
}
