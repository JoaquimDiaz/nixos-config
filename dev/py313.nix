# dev/py313.nix
{ pkgs }:

pkgs.mkShell {
  name = "py313";
  buildInputs = [
    pkgs.python313
    pkgs.python3Packages.ipython
    pkgs.python3Packages.jupytext
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
  ];

  shellHook = ''
    export PS1="[py313] $PS1"
    echo "py313 env started"
  '';
}
