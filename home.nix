{ config, pkgs, lib, ... }:

  {
  home.username = "debbie";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    steam
    libreoffice
    vlc
    signal-desktop
    feh
    google-chrome
  ];

  #home.sessionVariables = {
  #};

  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
