{
  description = "Development environments";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    devShells = import ./default.nix { inherit pkgs; };
  in
  {
    devShells.${system} = devShells;
  };
}

