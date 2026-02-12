{ config, pkgs, lib, ... }:

  let
    flathubApps = [
     "com.vscodium.codium"
     "org.gnome.Podcasts"
    ];

in {
home.activation.flatpak = lib.hm.dag.entryAfter ["writeBoundary"] ''
  ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo

  ${pkgs.flatpak}/bin/flatpak install --user -y flathub \
    ${lib.concatStringsSep " " flathubApps}
'';
  
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    oh-my-posh
    gzdoom
    dosbox
    pcsx2
    steam
    dvdplusrwtools
    cdrtools
    libreoffice
  ];

  home.file = {
    ".config/sway/config".source = ./configs/sway/config;
    ".config/sway/config.d/marty".source = ./configs/sway/config.d/marty;
    ".config/foot/foot.ini".source = ./configs/foot/foot.ini;
    ".config/swaybar/swaybar.sh".source = ./configs/swaybar/swaybar.sh;
    ".tmux.conf".source = ./configs/tmux/tmux.conf;
    ".poshthemes/easy-term.omp.json".source = ./configs/zsh/easy-term.omp.json;
    ".config/pipewire/pipewire.conf.d/zeroconf-discover.conf".source = ./configs/pipewire/zeroconf-discover.conf;
  };
  
  #home.sessionVariables = {
  #};

###########################################

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number relativenumber
      set mouse=a
    '';
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
  initExtra = ''
    eval "$(oh-my-posh init zsh --config ${config.home.homeDirectory}/.poshthemes/easy-term.omp.json)"
    export TERM=linux
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
