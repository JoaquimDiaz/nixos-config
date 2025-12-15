# common.nix
{ pkgs, ... }:
{
  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Power + battery + brightness
  services.tlp.enable = true;
  services.upower.enable = true;

  # For automounting USB drives in a user session
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Package manager
  programs.npm.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term-slab
  ];

  environment.systemPackages = with pkgs; [
    unzip
    alacritty
    neovim
    bat
    wget
    git
    tree
    xclip
    udiskie
    firefox
    brave
    btop
    pulseaudio # used for pactl 

    vscodium

    #image viewer
    imv

    #display
    xorg.xrandr
    redshift
    xwallpaper

    #notification
    dunst
    libnotify

    #package manager
    uv
    cargo

    #c
    gdb
    gcc
    gnumake
    pkg-config
    cmake
    cling

    #anki
    anki
  ];
}
