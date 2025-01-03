{ config, pkgs, lib, nixpkgs-master, ... }:

{
    home = {
      shellAliases = {
        nixconfig = "kate /home/jankoh/.dotfiles";
        nixrebuild = ''cd /home/jankoh/.dotfiles && sudo nixos-rebuild switch --flake . --impure'';
        labymod = "appimage-run \"/home/jankoh/Appimages/LabyMod Launcher-latest.AppImage\"";
        netflix = "xdg-open https://www.netflix.com";
        nixsearch = "xdg-open https://search.nixos.org/packages";
        youtube = "xdg-open https://www.youtube.com/";
        disney = "xdg-open https://www.disneyplus.com/en-gb/select-profile";
        cleanold = "sudo nix-collect-garbage -d";
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
      git
      openscad
      superTuxKart
      gimp
      qbittorrent
      motrix
      retroarch
      github-desktop
    ];

    nixpkgs.config.allowUnfree = true;

    programs.bash = {
      enable = true;
      initExtra = "fastfetch";
    };

    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "24.11";
}

