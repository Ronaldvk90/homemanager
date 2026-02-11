{ config, pkgs, ... }:


{
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";

  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    gzdoom
    dosbox
    steam
    dvdplusrwtools
    cdrtools
  ];

  home.file = {
    ".config/sway/config".source = ./configs/sway/config;
    ".config/foot/foot.ini".source = ./configs/foot/foot.ini;
    ".config/swaybar/swaybar.sh".source = ./configs/swaybar/swaybar.sh;
    ".tmux.conf".source = ./configs/tmux.conf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ronald/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  TERM = "xterm";
  };

###########################################
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
