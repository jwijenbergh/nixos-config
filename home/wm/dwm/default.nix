{ pkgs, ... }:

let
  theme = (import ../themes).current;
in
{
  imports = [ ../../server/x11.nix ];

  nixpkgs.overlays = [
    (self: super: {
		dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    		src = super.fetchFromGitHub {
    		  repo = "dwm";
    		  owner = "jwijenbergh";
    		  rev = "03095377fbeae6e5b66cc6dbbb5c0d09bd47f62c";
    		  sha256 = "0r42w8jf9fcp2cn4mwsr8ga4570ah6fxyrwxz6rwp31zkl7441hy";
    		};
  		});
    })
  ];

  home.packages = [ pkgs.dwm pkgs.dmenu ];

  home.file.".xprofile".text = ''
    feh --bg-scale "$HOME/Pictures/Wallpapers/current.png"
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
