# dev/py313-psql.nix
{ pkgs }:

pkgs.mkShell {
  name = "py313-psql";
  buildInputs = [
    pkgs.python313
    pkgs.python3Packages.ipython
    pkgs.python3Packages.jupytext
    pkgs.postgresql
    pkgs.postgresql.pg_config
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.libGL
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
  ];

  shellHook = ''
    export PS1="[py313-psql] $PS1"
    echo "py313-psql env started"
  '';
}

