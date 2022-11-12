#module to store programs 

{ config, pkgs, ... }: {

  programs = {

   bash = {
    shellInit = ''
    neofetch;
   '';
  };

  gnupg.agent = {
   enable = true;
   pinentryFlavor = "curses";
  };

  git = {
   enable = true;
   config = {
    user.name = "gregg00";
    user.email = "gregjsmith@gmx.com";
   };
  };

  neovim = {
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

  };


}
