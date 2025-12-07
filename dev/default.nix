# dev/default.nix
{ pkgs }:
{
  # python = import ./python.nix { inherit pkgs; };
  # node = import ./node.nix { inherit pkgs; };
  suckless = import ./suckless-dev.nix { inherit pkgs; };
  py-psql = import ./py-psql.nix { inherit pkgs; };
  py312 = import ./py312.nix { inherit pkgs; };
}
