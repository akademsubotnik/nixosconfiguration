{
  
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... } @ args: {
    #flake-utils.eachDefaultSystem ( system: {
      nixpkgs.config.allowUnfree = true;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        #system = ${system};
        modules = [
          ./configuration.nix
        ];
      };
    #};
  };
}
