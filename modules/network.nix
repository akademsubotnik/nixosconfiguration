#TURN THIS INTO A FLAKE!!!!!!!

{ config, pkgs, ... }:
{

  #NETWORKING#

        networking = {
                hostName = "nixos";
                useDHCP = false;
                interfaces.wlp4s0.useDHCP = true;
                networkmanager.enable = false;
                wireless = {
                        interfaces = [ "wlp4s0" ];
                        enable = true;
                        networks = {
                                #OpenWrt5ghz = {
                                #       psk = "x";
                                #}
                                FiOS-EL4ZU = {
                                        psk = "x";
                                };
                        };
                };
        };

  #END NETWORKING#

}
