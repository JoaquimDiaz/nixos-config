{ pkgs }:

pkgs.mkShell {
  name = "suckless-dev";

  packages = with pkgs; [
    pkg-config
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    fontconfig
    freetype
    harfbuzz
    gcc
    gnumake
  ];

  shellHook = ''
    echo "suckless env started"
  '';
}

