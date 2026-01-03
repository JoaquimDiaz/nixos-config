# dev/c.nix
{ pkgs }:

pkgs.mkShell {
  name = "c";
  buildInputs = [
  ];

  shellHook = ''
    export PS1="[c] $PS1"
    echo "c env started"
  '';
}
