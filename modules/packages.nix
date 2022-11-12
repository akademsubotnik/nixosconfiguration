#module to store installed packages 

{ config, pkgs, ... }: {

   #PACKAGES#
     # List packages installed in system profile. To search, run:
     # $ nix search wget
     nixpkgs.config.allowUnfree = true;
     nixpkgs.config.packageOverrides = {
       neofetch = pkgs.neofetch.override {
         environment.etc = {
            neofetch.source = /etc/nixos/modules/config.conf;
         };
	 environment.systemPackages = with pkgs; [
	   neofetch
	 ];
       };
     };

     environment.systemPackages = with pkgs; [
       #Package purposes
          #Web browsers
             firefox
             chromium
	     brave

          #Misc Applications
             slack
             vlc
             spotify
             zoom-us
             qbittorrent
             libreoffice
             koreader
             bisq-desktop
             #xen
	     bitcoind-knots

          #Misc Utilities
             wget
             ncftp
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
             steam-run
	     bind
	     songrec
             phototonic
             #mmex

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
