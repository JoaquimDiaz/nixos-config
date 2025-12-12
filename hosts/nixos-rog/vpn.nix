#vpn.nix
{ pkgs, ... }:
{
  programs.openvpn3.enable = true;

  environment.systemPackages = with pkgs; [
    openvpn
    openvpn3
    remmina
  ];

}
