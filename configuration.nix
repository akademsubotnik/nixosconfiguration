# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

    # Set your time zone.
    time.timeZone = "Europe/Kiev";
    hardware.pulseaudio.enable = true;
    nixpkgs.config.pulseaudio = true;
    programs.waybar.enable = true; #taskbar for wayland


    users.users.greg = {
          isNormalUser = true;
          extraGroups = [ "wheel" "audio" "sway" "video" ]; # Enable ‘sudo’ for the user.
    };




     #NeoVim#
     programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        configure = {
          #.vimrc goes in "customRC"
          customRC = ''
            set number
            let g:rainbow_active = 1
          '';
      packages.myVimPackage = with pkgs.vimPlugins; {

      start = [ YouCompleteMe rainbow ];

      };

      };

      };
      #End NeoVim#


      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "21.11"; # Did you read the comment?
      system.autoUpgrade.enable = true; #Enable unnatended upgrades to keep applications up to date and secure #FOR SECURITY #will check pkgs for updates 1x day

        #Git#
        programs.git = {
          enable = true;
          config = {
            user.name = "gregg00";
            user.email = "gregjsmith@gmx.com";
          };
        };
        #End Git#

        environment.shellAliases = {
          ls = "ls --color=auto";
          ll = "ls -l";
          h = "history";
        };

        services = {
                printing.enable = true;
                openssh.enable = true;
                openssh.permitRootLogin = "no";
                openssh.passwordAuthentication = true;
                flatpak.enable = true;
        };

        #Enable gpg#
        programs.gnupg = {
          agent = {
            enable = true;
            pinentryFlavor = "curses";
          };
        };
        #End Enable gpg#

  #END MISC#


   #NETWORKING#
      networking.hostName = "nixos"; # Define your hostname.
      networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      networking.wireless.networks = {
         #SSID = {                # SSID with no spaces or special characters
         #  psk = "";
         #};
         "SSID" = {
           psk = "";
         };
      };


   #END NETWORKING#


  #DISPLAY#
        programs.sway = {
                enable = true;
                wrapperFeatures.gtk = true;
                extraPackages = with pkgs; [
                        wl-clipboard
                        alacritty
                ];

        };

        xdg.portal.enable = true;
        xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];


  #END DISPLAY#


  #PACKAGES#
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      wget
      firefox
      slack
      chromium
      dpkg
      file
      qalculate-gtk
      vlc
      ncspot
      spotify
      zoom-us
      qbittorrent
      unzip
      meson
      #realvnc-vnc-viewer
      koreader
      libreoffice
      lynx
      waypipe
      wayvnc
      handlr
      waybar
      killall
      brightnessctl
      kubectl
      parted
      gnupg
      rng-tools
      pinentry_curses
      git-crypt
      pass
      python
      traceroute
      unar
      cryptsetup
      light
      wayland
      bisq-desktop
    ];
  #END PACKAGES


}
