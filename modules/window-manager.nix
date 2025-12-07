# window-manager.nix
{ pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      bigclock = "en";
      clear_password = "true";
      default_input = "password";
    };
  };

  # Configure lid closing behavior
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  # Session start script - Wallpaper + DWM bar
  services.xserver.displayManager.sessionCommands = ''
      xwallpaper --focus ~/nixos-config/walls/jupiter-marble.jpg
      autorandr --change --default mobile
      while true; do
          CAP=$(cat /sys/class/power_supply/BAT0/capacity)

          if   [ "$CAP" -ge 80 ]; then ICON="󱊣"
          elif [ "$CAP" -ge 50 ]; then ICON="󱊢"
          elif [ "$CAP" -ge 20 ]; then ICON="󱊡"
          else ICON="󰂎"
          fi

          BAT="$ICON $CAP%"
          DISK=$(df -h / | awk 'NR==2{print $4}')
          WIFI="  $(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')"
          [ -z "$WIFI" ] && WIFI="  offline"
          xsetroot -name "$(printf '%s | %s | %s | %s' "$BAT" "$WIFI" "$DISK" "$(date '+%H:%M')")"
          sleep 60
      done &
      flameshot &
      '';

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs {
      src = ../config/dwm;
    };
  };
}
  
