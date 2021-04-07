{ pkgs, ... }:
let
  theme = (import ../../env.nix).theme;
in
{
  # Some packages
  home.packages = with pkgs; [
    rofi
  ];

  xdg.configFile = {
    "rofi/config.rasi".text = ''
configuration {
  theme: "~/.config/rofi/themes/jerry.rasi";
  font: "Iosevka Nerd Font 14";
}
'';
    "rofi/themes/jerry.rasi".text = ''
/*******************************************************************************
 * ROFI Color theme adapted from Rasmus Steinke at https://raw.githubusercontent.com/davatorium/rofi/next/themes/android_notification.rasi
 * User: Jerry
 *******************************************************************************/
* {
    selected-normal-foreground:  #${theme.color3};
    foreground:                  #${theme.foreground};
    normal-foreground:           @foreground;
    alternate-normal-background: #${theme.background};
    red:                         #${theme.color9};
    selected-urgent-foreground:  #${theme.color3};
    blue:                        #${theme.color12};
    urgent-foreground:           #${theme.foreground};
    alternate-urgent-background: #${theme.background};
    active-foreground:           #${theme.color3};
    lightbg:                     #${theme.background};
    selected-active-foreground:  #${theme.color3};
    alternate-active-background: #${theme.background};
    background:                  #${theme.background};
    bordercolor:                 #${theme.color3};
    alternate-normal-foreground: @foreground;
    normal-background:           #${theme.background};
    lightfg:                     #${theme.background};
    selected-normal-background:  #${theme.background};
    border-color:                #${theme.color3};
    spacing:                     2;
    separatorcolor:              #${theme.color3};
    urgent-background:           #${theme.background};
    selected-urgent-background:  #${theme.background};
    alternate-urgent-foreground: @urgent-foreground;
    background-color:            #${theme.background};
    alternate-active-foreground: @active-foreground;
    active-background:           #${theme.background};
    selected-active-background:  #${theme.background};
}
window {
    background-color: @background;
    border:           1;
    padding:          5;
}
mainbox {
    border:  0;
    padding: 0;
}
message {
    border:       1px dash 0px 0px ;
    border-color: @separatorcolor;
    padding:      1px ;
}
textbox {
    text-color: @foreground;
}
listview {
    fixed-height: 0;
    border:       2px dash 0px 0px ;
    border-color: @separatorcolor;
    spacing:      2px ;
    scrollbar:    true;
    padding:      2px 0px 0px ;
}
element {
    border:  0;
    padding: 1px ;
}
element.normal.normal {
    background-color: @normal-background;
    text-color:       @normal-foreground;
}
element.normal.urgent {
    background-color: @urgent-background;
    text-color:       @urgent-foreground;
}
element.normal.active {
    background-color: @active-background;
    text-color:       @active-foreground;
}
element.selected.normal {
    background-color: @selected-normal-background;
    text-color:       @selected-normal-foreground;
}
element.selected.urgent {
    background-color: @selected-urgent-background;
    text-color:       @selected-urgent-foreground;
}
element.selected.active {
    background-color: @selected-active-background;
    text-color:       @selected-active-foreground;
}
element.alternate.normal {
    background-color: @alternate-normal-background;
    text-color:       @alternate-normal-foreground;
}
element.alternate.urgent {
    background-color: @alternate-urgent-background;
    text-color:       @alternate-urgent-foreground;
}
element.alternate.active {
    background-color: @alternate-active-background;
    text-color:       @alternate-active-foreground;
}
scrollbar {
    width:        4px ;
    border:       0;
    handle-width: 8px ;
    padding:      0;
}
mode-switcher {
    border:       2px dash 0px 0px ;
    border-color: @separatorcolor;
}
button.selected {
    background-color: @selected-normal-background;
    text-color:       @selected-normal-foreground;
}
inputbar {
    spacing:    0;
    text-color: @normal-foreground;
    padding:    1px ;
}
case-indicator {
    spacing:    0;
    text-color: @normal-foreground;
}
entry {
    spacing:    0;
    text-color: @normal-foreground;
}
prompt {
    spacing:    0;
    text-color: @normal-foreground;
}
inputbar {
    children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
}
textbox-prompt-colon {
    expand:     false;
    str:        ":";
    margin:     0px 0.3em 0em 0em ;
    text-color: @normal-foreground;
}
'';
  };
}
