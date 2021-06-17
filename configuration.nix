{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x1/7th-gen"
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # luks
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/a20cb4b9-7510-4783-b6c2-98d3d02629dc";
      preLVM = true;
    };
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  networking.firewall.enable = true;
  networking.firewall.allowPing = false;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services.keybase.enable = true;
  services.kbfs.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
     ];
    };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  programs.fish.enable = true;

  programs.gnupg.agent.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bast = {
    isNormalUser = true;
    home = "/home/bast";
    shell = pkgs.fish;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    vim
    wget
    curl
    git
    meld
  ];

  system.stateVersion = "21.05";
}
