{ pkgs, ... }:
{
  # lf config
  xdg.configFile = {
    "lf/lfrc".source = ./lfrc;
  };
}
