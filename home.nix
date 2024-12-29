{ config, pkgs, lib, ... }:


{
    home = {
      shellAliases = {
        nixconfig = "kate /home/jankoh/.dotfiles";
        nixrebuild = ''cd /home/jankoh/.dotfiles && sudo nixos-rebuild switch --flake . --impure'';
        labymod = "appimage-run \"/home/jankoh/Appimages/LabyMod Launcher-latest.AppImage\"";
      };
    };
    home.packages = with pkgs; [
      flatpak
      neovim
      fastfetch
      libreoffice-still
      appeditor
      vscode-fhs
      discord
      dotnet-sdk_9
      gparted
      distrobox
      podman
      #bottles
      git
      kitty
      kitty-themes
      openscad
      orca-slicer
      superTuxKart
      gimp
      qbittorrent
      motrix
    ];

    nixpkgs.config.allowUnfree = true;

    programs.bash = {
      enable = true;
      initExtra = "fastfetch";
    };

    /* programs.kitty = {
       enable = true;
       font = {
         name = "JetBrainsMono Nerd Font";
         size = 10;
       };
       shellIntegration.enableBashIntegration = true;
       theme = "Kaolin Ocean";
      };*/

    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "24.11";
}

