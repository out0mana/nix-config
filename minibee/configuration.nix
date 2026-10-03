{ config, lib, pkgs, inputs, user, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./services.nix
      ../shared/git-personal.nix
      ../shared/home.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "minibee"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
  	font = "Lat2-Terminus16";
  	keyMap = "us";
  };

  # Define a user account.
  users.users.${user.name} = {
    isNormalUser = true;
    uid = user.uid;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILuPPBvxo/cbR5HTKh+gdayZXOPZMrVRg6T4iUcev4EH p001@debian" ];
    hashedPassword = "$y$j9T$FYpvRpDTucbN75V4dYVKi/$2xgOV1/1Q1SkUxigfZyoNlvsNDv4mID0jXBW.jKM0QA";
  };

  # Automount
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.udisks2.") === 0) {
        if (subject.isInGroup("wheel")) {
    return polkit.Result.YES;
        }
      }
    });
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "26.05"; # Dont change

}
