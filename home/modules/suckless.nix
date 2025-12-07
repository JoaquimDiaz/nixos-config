# suckless.nix
{ pkgs, dotfiles, ... }:
{
  home.packages = with pkgs; [
    # dmenu
    (pkgs.dmenu.overrideAttrs (_: {
      src = "${dotfiles}/dmenu";
    }))
  ];
}

