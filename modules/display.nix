#module for display

{ config, pkgs, ... }: {

   #DISPLAY#

         #programs.waybar.enable = true; #taskbar for wayland
         #programs.sway = {
         #       enable = true;
         #       wrapperFeatures.gtk = true;
         #       extraPackages = with pkgs; [
         #               wl-clipboard
         #               alacritty
         #       ];
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



}
