# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/system/hardware-configuration.nix
      ./modules/secrets/network.nix
    ];

  #KERNEL/BOOTUP#
	boot = {
		#Use the systemd-boot EFI boot loader (loader)
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		blacklistedKernelModules = [ "e1000e" ];
		kernelModules = [ "binder_linux" ];
		kernelPackages = pkgs.linuxPackages_xanmod;
	};

  #END KERNEL/BOOTUP#

  #NETWORKING#
  #/modules/secrets/network.nix
  #END NETWORKING#


  #MISC#
  	time.timeZone = "America/New_York";
	hardware.pulseaudio.enable = true;
	nixpkgs.config.pulseaudio = true;
  	virtualisation.docker.enable = true;
	programs.waybar.enable = true; #taskbar for wayland
	virtualisation.virtualbox.host.enable = true;
   	users.extraGroups.vboxusers.members = [ "greg" ];


  	users.users.greg = {
    		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "docker" "sway" "video" ]; # Enable ‘sudo’ for the user.

  	};


	services = {
		printing.enable = true;
		sshd.enable = true;
		flatpak.enable = true;
	};

        # This value determines the NixOS release from which the default
  	# settings for stateful data, like file locations and database versions
  	# on your system were taken. It‘s perfectly fine and recommended to leave
  	# this value at the release version of the first install of this system.
  	# Before changing this value read the documentation for this option
  	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  	system.stateVersion = "21.11"; # Did you read the comment?

	#ToDo
	#1. containerized applications
	#2. how to update system, not needed because of vc flakes???

	#Enable gpg#
	programs.gnupg = {
	  agent = {
	    enable = true;
	    pinentryFlavor = "curses";
	  };
	};
	#End Enable gpg#
	
	#NeoVim#
        programs.neovim = {
          enable = true;
          defaultEditor = true;
	  #package = pkgs.neovim-nightly;
	  viAlias = true;
          configure = {
	    customRC = ''
	      set undofile
	    '';
	  packages.myVimPackage = with pkgs.vimPlugins; {

          start = [ vim-nix ];
          #start = [
          #(nvim-treesitter.withPlugins (
          #  plugins: with plugins; [
          #    tree-sitter-nix
          #    tree-sitter-python
          #  ]
          #))
          #YouCompleteMe ];


	  };

	  };
	  
	};
	#End NeoVim#

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
          ll = "ls -l";
          h = "history";
        };



  #END MISC#

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
      neovim

    ];
  #END PACKAGES

  #nix flakes (https://nixos.wiki/wiki/flakes#Installing_flakes)
  nix = {
  	package = pkgs.nixUnstable; #or versioned attributes like nix_2_4
  	extraOptions = ''
  		experimental-features = nix-command flakes
  	'';
  };



}

