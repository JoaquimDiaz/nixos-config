# bash.nix
{ pkgs, laptop, ... }:
let
  configDir = "$HOME/nixos-config";
in
{
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ${configDir}#${laptop}";
      nrs-vm = "sudo nixos-rebuild build-vm --flake ${configDir}#${laptop}";
      hmb = "home-manager -f ${configDir}/home.nix switch";
      btw = "echo i use nixos, btw";
      # fzf aliases
      f = "cd $(fd --type d --hidden --exclude .git --exclude .cache --exclude .venv --exclude .npm --exclude .mozilla | fzf)";
      v = ''vim "$(fd --hidden --type f \
        --exclude .vim \
        --exclude .git --exclude .cache --exclude .venv --exclude .npm --exclude .mozilla \
        | fzf --preview "bat --style=numbers --color=always {}")"''; 
      rgf = ''
        vim $(rg --line-number --hidden --glob '!.git' . \
          | fzf --delimiter ':' \
                 --preview 'bat --style=numbers --color=always {1}' \
          | awk -F: '{print "+"$2" "$1}')
      '';
   };

# export PS1="\[\e[38;5;28m\]\u@\h \[\e[38;5;75m\]\w \[\e[38;5;189m\]\$(__git_ps1 ' (%s)') \$ \[\e[0m\]"
    initExtra = ''
      set -o vi
      export EDITOR=nvim
      export VISUAL=nvim

      bind -m vi-command '"\C-p": previous-history'
      bind -m vi-command '"\C-n": next-history'
      bind -m vi-insert '"\C-p": previous-history'
      bind -m vi-insert '"\C-n": next-history'

      if [ -f ${pkgs.git}/share/git/contrib/completion/git-prompt.sh ]; then
            . ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
      fi

      GIT_PS1_SHOWDIRTYSTATE=1
      GIT_PS1_SHOWSTASHSTATE=1
      GIT_PS1_SHOWUNTRACKEDFILES=1
      GIT_PS1_SHOWUPSTREAM="auto"

      export PS1="\[\e[38;5;10m\]\u@\h \[\e[38;5;75m\]\w \[\e[38;5;189m\]\$(__git_ps1 ' (%s)') \$ \[\e[0m\]"
    '';
  };
}
