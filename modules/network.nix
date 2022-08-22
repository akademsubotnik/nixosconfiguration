#module to store network configuration, add to git ignore file

{ config, pkgs, ... }: {

imports = [ ./secrets.nix ];

 networking.hostName = "nixos"; # Define your hostname.
 networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
 #networking.wireless.networks = {
 #   SSID = {                # SSID with no spaces or special characters
 #     psk = ""; 
 #   };
 #};
}
