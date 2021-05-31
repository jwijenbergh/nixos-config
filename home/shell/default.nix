{ pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  # Set shell packages
  home.packages = with pkgs; [
    #bat
    exa
    fd
    gotop
    nnn
    ripgrep
    tealdeer
    unstable.fzf
  ];

  # Shell + associated packages that need some configuration
  programs = {
    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
      enableFishIntegration = true;
    };
    fish = {
      enable = true;
      shellAbbrs = {
        e = "emacsclient -c";
        ls = "exa -l";
        ll = "exa -al";
        f = "nnn";
      };
      shellInit = ''
        set -gx EDITOR 'emacsclient -c'
        function fish_greeting; end
        set -U fish_prompt_pwd_dir_length 0
	      set -U fish_color_normal normal
	      set -U fish_color_command F8F8F2
	      set -U fish_color_quote F1FA8C
	      set -U fish_color_redirection 8BE9FD
	      set -U fish_color_end 50FA7B
	      set -U fish_color_error FFB86C
	      set -U fish_color_param FF79C6
	      set -U fish_color_selection white --bold --background=brblack
	      set -U fish_color_search_match bryellow --background=brblack
	      set -U fish_color_history_current --bold
	      set -U fish_color_operator 00a6b2
	      set -U fish_color_escape 00a6b2
	      set -U fish_color_cwd green
	      set -U fish_color_cwd_root red
	      set -U fish_color_valid_path --underline
	      set -U fish_color_autosuggestion BD93F9
	      set -U fish_color_user brgreen
	      set -U fish_color_host normal
	      set -U fish_color_cancel -r
	      set -U fish_pager_color_completion normal
	      set -U fish_pager_color_description B3A06D yellow
	      set -U fish_pager_color_prefix white --bold --underline
	      set -U fish_pager_color_progress brwhite --background=cyan
	      set -U fish_color_match --background=brblue
	      set -U fish_color_comment 6272A4
      '';
    };
    #fzf = {
    #  enable = true;
    #  package = unstable.fzf;
    #  defaultCommand = "rg --files --hidden";
    #};
    git = {
      enable = true;
      userName = "Jeroen Wijenbergh";
      userEmail = "jeroenwijenbergh@protonmail.com";
    };
  };
}
