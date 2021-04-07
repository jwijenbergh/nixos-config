# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Use home manager
      "${builtins.fetchGit {
        ref = "release-20.09";
        url = "https://github.com/jwijenbergh/home-manager";
      }}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    enableCryptodisk = true;
    device = "nodev";
    useOSProber = true;
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/8181bac2-7bd8-4e87-b840-2c7cb3ce1d8c";
      preLVM = true;
    };
  };

  environment.systemPackages = [ pkgs.ntfs3g ];

  networking.hostName = "deskie"; # Define your hostname.
  networking.networkmanager.enable = true; # Use network manager
  networking.iproute2.enable = true;
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.mullvad-vpn.enable = true;

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.startx.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };

  programs = {
    adb.enable = true;
    light.enable = true;
  };

  # Needed for piper
  services.ratbagd.enable = true;

  # Power management
  #services.tlp.enable = true;
  services.upower.enable = true;

  virtualisation = {
    virtualbox.host.enable = true;
    docker.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jerry = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "vboxusers" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # Home manager
  home-manager.users.jerry = { pkgs, ...}: {
    imports = [ ./home/home.nix ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

