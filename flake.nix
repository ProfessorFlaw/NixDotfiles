{
  description = "sysconfig Flake";

  inputs = {
    # NixOS official package source
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
      #url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      #url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ghostty-Flake hinzufügen
    ghostty.url = "github:ghostty-org/ghostty";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, ghostty, stylix, home-manager, nixpkgs-master, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jankoh = import /home/jankoh/.dotfiles/home.nix;

          # Extra-Argumente
          home-manager.extraSpecialArgs = { inherit (inputs) nixpkgs-master; };
        }
          {
          environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
