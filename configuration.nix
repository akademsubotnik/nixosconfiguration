# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/secrets/network.nix
    ];

  #nix flakes (https://nixos.wiki/wiki/flakes#Installing_flakes)
  nix = {
  	package = pkgs.nixUnstable; #or versioned attributes like nix_2_4
  	extraOptions = ''
  		experimental-features = nix-command flakes
  	'';
  };
  

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
		xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager). SUPERFLUOUS WITH WAYLAND????
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

  #END MISC#

  #NETWORKING#
  #/modules/network.nix#	
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

	xdg.portal = {
		enable = true;
		wlr.enable = true;
	};
  #END DISPLAY#

  #PACKAGES#
  	nixpkgs.config = {
    		allowUnfree = true; # allow unfree packages(eg. slack)
  	};
  	environment.systemPackages = with pkgs; [
    	vim
    	wget
    	firefox
    	slack
    	git
    	#chromium
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
    	realvnc-vnc-viewer
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

  	];

  #END PACKAGES#

}

