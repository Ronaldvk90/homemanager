{ config, pkgs, lib, ... }:

  {
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    oh-my-posh
  ];

  home.file = {
    ".tmux.conf".source = ./configs/tmux/tmux.conf;
    ".poshthemes/easy-term.omp.json".source = ./configs/zsh/easy-term.omp.json;
  };

###########################################
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
  initExtra = ''
    eval "$(oh-my-posh init zsh --config ${config.home.homeDirectory}/.poshthemes/easy-term.omp.json)"
    bindkey "^[[1;3D" backward-word
    bindkey "^[[1;3C" forward-word
    bindkey  "^[[H"   beginning-of-line
    bindkey  "^[[F"   end-of-line

    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
  '';
  };
 
  programs.git = {
    package = pkgs.git;
    enable = true;
    settings.user.name = "Ronald van Kouwen";
    settings.user.email = "ronaldvk90@outlook.com";
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };

  programs.tmate = {
    enable = true;
  };

###############################################
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
