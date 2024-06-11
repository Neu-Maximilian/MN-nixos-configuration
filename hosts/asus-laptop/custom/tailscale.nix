# tailscale.nix
{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
  };
}
