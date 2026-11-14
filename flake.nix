{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { self, nixpkgs, nix-flatpak, ... } @ inputs: {
    nixosConfigurations."rher" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";

      modules = [
        ./hosts/rher
        nix-flatpak.nixosModules.nix-flatpak
      ];
    };

    nixosConfigurations."gro-goroth" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";

      modules = [
        ./hosts/gro-goroth
        nix-flatpak.nixosModules.nix-flatpak
      ];
    };
  };
}
