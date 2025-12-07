# suckless.nix
{ pkgs, dotfiles, ... }:
{
  home.packages = with pkgs; [
    # st
    (pkgs.st.overrideAttrs (_: {
      src = "${dotfiles}/st";
    }))

    # dmenu
    (pkgs.dmenu.overrideAttrs (_: {
      src = "${dotfiles}/dmenu";
    }))
  ];
}

