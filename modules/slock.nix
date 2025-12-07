# slock.nix
{ pkgs, ... }:
let
  mySlock = pkgs.slock.overrideAttrs (oldAttrs: {
    src = ../config/slock;
    
    buildInputs = with pkgs; [
      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXft
      freetype
      fontconfig
      imlib2
    ] ++ (oldAttrs.buildInputs or []);
  });
in
{
  environment.systemPackages = [ mySlock ];
  
  security.wrappers.slock = {
    owner = "root";
    group = "root";
    setuid = true;
    source = "${mySlock}/bin/slock";
  };
}
