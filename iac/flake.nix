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
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, sshKeys, nixpkgs, nixos-generators, terranix, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    specialArgs = {
      inherit sshKeys;
      inherit pkgs;
    };
    modules = [
      ./modules/common.nix
      ./modules/hardware.nix
      {
        nix.registry.nixpkgs.flake = nixpkgs;
      }
    ];
    systems = [
      {
        name = "example";
        value = {
          inherit system;
          modules = modules ++ [
            # modules/example.nix
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

    nixosConfigurations = builtins.listToAttrs (map (x: { name = x.name; value = nixpkgs.lib.nixosSystem x.value; }) systems);    
  };
}
