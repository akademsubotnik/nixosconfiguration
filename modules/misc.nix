#module to store misc

{ config, pkgs, ... }: {

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
        };};};
        
        #End NeoVim#
 
        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "21.11"; # Did you read the comment?
        system.autoUpgrade.enable = true; #Enable unnatended upgrades to keep applications up to date and secure #FOR SECURITY #will check pkgs for updates     1x day
 
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
         PATH = [
           "/home/greg/Projects/nix-packages-ADD/java-packages-to-nixify/gradle2nix/result/bin"
         ];
       };
       #END ENVIRONMENT VARIABLES#

   #END MISC#
}
