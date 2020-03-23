# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ 
    # XPS 13 9350 is pretty much the xps 15 9550 but 13 inch
    <nixos-hardware/dell/xps/15-9550> 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include my own home-manager repo to cherry pick modules
    "${builtins.fetchGit {
      ref = "release-19.09";
      url = "https://github.com/jwijenbergh/home-manager";
    }}/nixos"
  ];

  # Full disk encryption
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/nvme0n1p2";
      preLVM = true;
    }
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Networking config
  networking.hostName = "xps"; # Define your hostname.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp58s0.useDHCP = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # environment.systemPackages = with pkgs; [
  # ];

  programs = { 
    fish.enable = true;
    light.enable = true;
    nm-applet.enable = true;
  };

  # List services that you want to enable:
  services.dbus.packages = [ pkgs.gnome3.dconf ];
  services.udev.packages = [ pkgs.stlink ];

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    desktopManager = {
      session = [{
        name = "home-manager";
        start = ''
          ${pkgs.runtimeShell} $HOME/.hm-xsession &
          waitPID=$!
        '';
      }];
      default = "home-manager";
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Bluetooth breaks my wireless adapter sometimes, solutions do not seem to work.
  #hardware.bluetooth.enable = true;

  # Need docker sometimes
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jerry = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "dialout" "docker" "vboxusers" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # Home manager config
  home-manager.users.jerry = { pkgs, ... }: {
    imports = [ ./home/home.nix ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

