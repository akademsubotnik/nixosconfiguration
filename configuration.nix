# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/network.nix
      ./modules/display.nix
      ./modules/packages.nix
      ./modules/misc.nix
    ];

#KERNEL/BOOTUP#

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    version = 2;
    efiSupport = true;
    enableCryptodisk = true;
  };
  
  boot.initrd = {
    luks.devices."root" = {
      device = "/dev/disk/by-uuid/eee08ded-d73d-478f-b593-c47c62646cfe"; # UUID for /dev/nvme01np2 
      preLVM = true;
      keyFile = "/keyfile0.bin";
      allowDiscards = true;
    };
    secrets = {
      # Create /mnt/etc/secrets/initrd directory and copy keys to it
      "keyfile0.bin" = "/etc/secrets/initrd/keyfile0.bin";
    };
};

  boot.blacklistedKernelModules = [ "e1000e" ];
  boot.kernelModules = [ "binder_linux" ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

#END KERNEL/BOOTUP#

  #MISC#
  #./modules/misc.nix
  #END MISC#

  #NETWORKING#
  #./modules/network.nix
  #END NETWORKING#

  #DISPLAY#
  #./modules/display.nix
  #END DISPLAY#

  #PACKAGES#
  #./modules/packages.nix
  #END PACKAGES

}

