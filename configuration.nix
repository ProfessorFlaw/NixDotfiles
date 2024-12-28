{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  #enable xorg
  services.xserver.enable = true;

  #Displaymanager
  services.displayManager = {
    ly = {
      enable = true;
    };
  };

  #DesktopEnvoirementDE
  services.desktopManager.plasma6.enable = true;

  #Keyboard layout
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  #CUPS (Printing)
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #UserACC
  users.users.jankoh = {
    description = "Janko Hartig";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  #firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Global Packages
  environment.systemPackages = with pkgs; [
    wget
    neovim
    fastfetch
    pkgs.appimage-run
    pkgs.distrobox
    ly
    git
    base16-schemes
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  programs.steam.enable = true;

  programs.gnupg.agent = {
    enable = true;
    #enableSSHSupport = true;
    };

  # Enable the OpenSSH daemon.
    /*services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    }; */

    stylix = {
      image = /home/jankoh/.dotfiles/wallpaper2.jpg;
      enable = true;
      polarity = "dark";
      autoEnable = true;
    };

  home-manager.backupFileExtension = "backup3";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?




  #========================================================================================================
  #                                      Homemanager
  #========================================================================================================
  users.users.jankoh.isNormalUser = true;
  home-manager.users.jankoh = { pkgs, ... }: {
    home = {
      shellAliases = {
          nixconfig = "kate /home/jankoh/.dotfiles";
          nixrebuild = ''cd /home/jankoh/.dotfiles/
          sudo nixos-rebuild switch --flake . --impure'';
          labymod = "appimage-run /home/jankoh/Appimages/LabyMod\\ Launcher-latest.AppImage";
          #kittythemes = "kitty +kitten themes";
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
      bottles
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
      #autostart
      initExtra = "fastfetch";
    };

    /*programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      shellIntegration.enableBashIntegration = true;
      theme = "Kaolin Ocean";
    };*/

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.11";
};

}
