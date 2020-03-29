{ pkgs, ... }:

{
  # Use my own st build
  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        src = /home/jerry/Repos/st;
      });
    })
  ];

  # Install it
  home.packages = [ pkgs.st ];

  # Pywal template
  xdg.configFile = 
  {
    "wal/templates/st".text = ''
       st.foreground:       {foreground}
       st.background:       {background}
       st.color0:           {color0}
       st.color8:           {color8}
       st.color1:           {color1}
       st.color9:           {color9}
       st.color2:           {color2}
       st.color10:          {color10}
       st.color3:           {color3}
       st.color11:          {color11}
       st.color4:           {color4}
       st.color12:          {color12}
       st.color5:           {color5}
       st.color13:          {color13}
       st.color6:           {color6}
       st.color14:          {color14}
       st.color7:           {color7}
       st.color15:          {color15}
    '';
  };
}
