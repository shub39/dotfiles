{
  description = "shub39's Nix configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    hermes-agent.url = "github:NousResearch/hermes-agent";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { self, nixpkgs, nix-flatpak, nix-darwin, nix-homebrew, ... } @ inputs: {
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

    nixosConfigurations."sylvian" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";

      modules = [
        ./hosts/sylvian
        nix-flatpak.nixosModules.nix-flatpak
      ];
    };

    darwinConfigurations."alll-mer" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/alll-mer
        nix-homebrew.darwinModules.nix-homebrew
      ];
    };
  };
}
