{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {

    # System configuration
    # Available through 'nixos-rebuild switch --flake .#username@hostname'
    nixosConfigurations = {
      "bf-109" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit nixpkgs home-manager;
        };

        modules = [
          ./hosts/asus-laptop
          ./hosts/shared
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.maximiliann = import ./home/maximiliann;
          }
        ];
      };
    };

    # home-manager configurations
    # Available through 'home-manager <command> --flake .#username@hostname'
    homeConfigurations = {
        "maximiliann" =
            home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages."x86_64-linux";
              modules = [ ./home/maximiliann ];
            };
      };
  };
}
