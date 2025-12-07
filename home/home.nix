{ self, config, pkgs, hostName, ... }:

let
  username = "jo";
  laptop = hostName;
  configDir = "${self}";
  dotfiles = "${self}/config";
  dotconfig = "/home/${username}/nixos-config/config";

  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    nvim = "nvim";
    alacritty = "alacritty";
    dunst = "dunst";
  };
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  imports = [
    ./modules/flameshot.nix 
    ./modules/qutebrowser.nix
    (import ./modules/bash.nix { inherit configDir laptop pkgs; })
    (import ./modules/suckless.nix { inherit dotfiles pkgs; })
  ];

  # gtk config
  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  # git config
  programs.git = {
    enable = true;
    settings = {
      user.name = "Joaquim Diaz";
      user.email = "diazjoaquim@gmail.com";
      core.editor = "nvim";
    };
  };

  # fuzzy finder
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotconfig}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [

    # Personnal scripts under "${config-folder}/home/scripts"
    (pkgs.runCommand "my-scripts" { } ''
      mkdir -p $out/bin
      cp ${./scripts}/* $out/bin/
      chmod +x $out/bin/*
    '')

    tmux
    ripgrep
    fd
    nixpkgs-fmt

    #lsp
    nil
    basedpyright
    clang-tools
    lua-language-server
    nodePackages.typescript-language-server
    nodePackages.typescript
  ];
}

