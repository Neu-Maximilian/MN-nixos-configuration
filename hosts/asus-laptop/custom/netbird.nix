# tailscale.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    netbird-ui
  ];
  services.netbird = {
    enable = true;
  };
}
