#module to store installed packages 

{ config, pkgs, ... }: {

   #PACKAGES#
     # List packages installed in system profile. To search, run:
     # $ nix search wget
     nixpkgs.config.allowUnfree = true;


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
