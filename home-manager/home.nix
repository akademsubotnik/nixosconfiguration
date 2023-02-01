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


  programs.git = {
    enable = true;
    userName = "gregg00";
    userEmail = "gregjsmith@gmx.com";
  }; 


  programs.vim = {
    enable = true;
    extraConfig = ''
      syntax on
    '';
  };

  #Packages you want to install
  home.packages = [
    pkgs.tmux
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export EDITOR="vi";
      PATH="/home/greg/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/Users/Chuwi/AppData/Local/Microsoft/WindowsApps:/snap/bin" ;

      # enable color support of ls and also add handy aliases
      if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
      fi 

      # some more ls aliases
      alias ll='ls -alF'
      alias la='ls -A'
      alias l='ls -CF'
      alias diff='colordiff'
      alias oports='netstat -tulanp'
      alias wget='wget -c'



      # append to the history file, don't overwrite it
      shopt -s histappend

      ## Enables displaying colors in the terminal
      force_color_prompt=yes

      #Have terminal name have color
      PS1='\e[32;1m\u@\h: \e[32m\W\e[32m\$ '

    '';
  };
}
