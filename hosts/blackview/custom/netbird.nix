# tailscale.nix
{ config, pkgs, ... }:

{
  services.netbird = {
    enable = true;
  };
}