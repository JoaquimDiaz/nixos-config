# dev/py312.nix
{ pkgs }:

pkgs.mkShell {
  name = "py312";
  buildInputs = [
    pkgs.python312
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
  ];

  shellHook = ''
    export PS1="[py312] $PS1"
    echo "py312 env started"
  '';
}

