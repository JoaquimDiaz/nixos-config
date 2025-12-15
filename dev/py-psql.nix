# dev/py-psql.nix
{ pkgs }:

pkgs.mkShell {
  name = "py-sql";
  buildInputs = [
    pkgs.uv
    pkgs.python312
    pkgs.python3Packages.ipython
    pkgs.python3Packages.jupytext
    pkgs.postgresql
    pkgs.postgresql.pg_config
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
  ];

  shellHook = ''
    export PS1="[py-psql] $PS1"
    echo "py-sql env started"
  '';
}

