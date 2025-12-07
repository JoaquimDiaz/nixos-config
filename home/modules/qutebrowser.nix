# qutebrowser.nix
{ ... }:
{
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
      c.colors.webpage.darkmode.enabled = True
      c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
      c.colors.webpage.darkmode.policy.images = 'never'
    '';
  };
}
