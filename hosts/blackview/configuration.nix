# --------------------------- configuration.nix ----------------------------- #
#
# The main configuration file of NixOs
#
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ lib, config, pkgs, ... }:

{
  # --------------------------- Set-up the system -------------------------- #
  networking.hostName = "me-262";


  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  
  virtualisation.waydroid.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
