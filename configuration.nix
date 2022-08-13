# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/network.nix
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

        #services.hydra = {
        #	enable = true;
        #	hydraURL = "http://localhost:3000"; # externally visible URL
        #	notificationSender = "hydra@localhost"; # e-mail of hydra service
        #	# a standalone hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
        #	buildMachinesFiles = [];
        #	# you will probably also want, otherwise *everything* will be built from scratch
        #	useSubstitutes = true;
        #};


	#Enable gpg#
	programs.gnupg = {
	  agent = {
	    enable = true;
	    pinentryFlavor = "curses";
	  };
	};
	#End Enable gpg#

        #SET DEFAULT APPLICATIONS#

        xdg.mime.enable = true;
        xdg.mime.addedAssociations = {
            "application/pdf" = "chromium-browser.desktop";
            #"text/xml" = [ "nvim.desktop" "codium.desktop" ];
        };

	#END SET DEFAULT APPLICATIONS#

       #Start use nix command#
       nix.extraOptions = ''
          experimental-features = nix-command
       '';
       #End use nix command#


      #START ENVIRONMENT VARIABLES#
      environment.variables = {
        DOMAIN = "aaa";
	PATH = [
          "/home/greg/Projects/nix-packages-ADD/java-packages-to-nixify/gradle2nix/result/bin"
	];
      };
      #END ENVIRONMENT VARIABLES#





  #END MISC#


   #NETWORKING#
   #/modules/network.nix
   #END NETWORKING#
   

  #DISPLAY#

        #programs.waybar.enable = true; #taskbar for wayland
  	#programs.sway = {
	#	enable = true;
	#	wrapperFeatures.gtk = true;
	#	extraPackages = with pkgs; [
	#		wl-clipboard 
	#		alacritty
	#	];
	#	
	#};

	#xdg.portal.enable = true; 
	#xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];


        #START TEMP DISPLAY#
        
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.openssh.forwardX11 = true;


	#END TEMP DISPLAY#

  #END DISPLAY#


  #PACKAGES#
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    nixpkgs.config.allowUnfree = true;
       

    environment.systemPackages = with pkgs; [
      #Package purposes
         #Web browsers
	    firefox
	    chromium

         #Misc Applications
	    slack
            vlc
            spotify
            zoom-us
            qbittorrent
	    #realvnc-vnc-viewer
	    tigervnc
	    libreoffice
            koreader
            bisq-desktop
	    #xen
            
         #Misc Utilities
	    wget
	    dpkg
            file
            unzip
            python
            traceroute
	    unrar
            parted
	    gnupg
	    rng-tools
	    killall
	    xdg-utils
	    gparted
	    nix-index
	    jdk
	    maven
	    steam-run
	    
	 #SORT ME PLSSS
	    waypipe
	    waybar
	    wayvnc
            brightnessctl
            kubectl
            pinentry_curses
            git-crypt
            pass
            unar
            cryptsetup
            wayland
	    cloudflare-warp
    ];
  #END PACKAGES


}

