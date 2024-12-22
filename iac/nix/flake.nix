{
  description = "NixOS VM configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sshKeys = {
      url = "https://github.com/LeonFroelje.keys";
      flake = false;
    };
  };

  outputs = { self, sshKeys, nixpkgs, nixos-generators, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    specialArgs = {
      inherit sshKeys;
      inherit pkgs;
    };
    modules = [
      ./configuration.nix
      ./hardware.nix
    ];
    systems = [
      {
        name = "vault";
        value = {
          inherit system;
          modules = modules ++ [
            modules/vault.nix
          ];
          inherit specialArgs;
        };
      }
      {
        name = "minecraft-local";
        value = {
          inherit system;
          modules = modules ++ [
            modules/minecraft-local.nix
          ];
          inherit specialArgs;
        };
      }
    ];
    qcow = {
      format = "qcow";
    };

  in {
    packages.${system} = builtins.listToAttrs (map (x: { name = x.name; value = nixos-generators.nixosGenerate (x.value // qcow); }) systems);
      # vault = nixos-generators.nixosGenerate (vault // qcow);

      # minecraft-local = nixos-generators.nixosGenerate (minecraft-local // qcow);
    # };
    nixosConfigurations = builtins.listToAttrs (map (x: { name = x.name; value = nixpkgs.lib.nixosSystem x.value; }) systems);
    # nixosConfigurations."vault" = nixpkgs.lib.nixosConfigurations vault;
    # nixosConfigurations."minecraft-local" = nixpkgs.lib.nixosSystem minecraft-local;
    
  };
}
