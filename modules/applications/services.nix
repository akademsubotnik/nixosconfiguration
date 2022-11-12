#module to store services 

{ config, pkgs, ... }: {

  services = {
    printing.enable = true;
    openssh = {
     enable = true;
     permitRootLogin = "no";
     passwordAuthentication = true;
    };
    flatpak.enable = true;
  };

}
