{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "greg";
  home.homeDirectory = "/home/greg";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  targets.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;

  programs.git = {
    enable = true;
    userName  = "gregg00";
    userEmail = "gregjsmith@gmx.com";
  };


  programs.bash = {
    enable = true;
    bashrcExtra = ''
      . ~/.bashrc-old
    '';
  };


  home.packages = [
    pkgs.tmux
  ];

}
