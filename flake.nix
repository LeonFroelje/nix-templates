{
  description = "Nix templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    templates = {
      iac = {
        path = ./iac;
        description = "Iac flake for my homelab";
      };
    };
  };
}
