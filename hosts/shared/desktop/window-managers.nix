{ pkgs, ... }:


let
  # Needed for hyprland
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland-flake = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in
{
  # Enable hyperland
  # First you can enable the cache server so that you don't have to compile the source again
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland, a compatibility layer over wayland for apps that don't supìport wayland yet
    xwayland.enable = true;
    # package = hyprland-flake.packages.${pkgs.system}.hyprland;
  };


  # Enable sway
  # programs.sway.enable = true;

  # Enable i3
  # services.xserver = {
  #   enable = true;
  #   desktopManager = {
  #     xterm.enable = false;
  #   };
  #   displayManager = {
  #       defaultSession = "none+i3";
  #   };
  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       # dmenu        # application launcher most people use
  #       rofi           # alternative to dmenu
  #       i3status       # gives you the default i3 status bar
  #       i3lock         # default i3 screen locker
  #       i3blocks       # if you are planning on using i3blocks over i3status
  #    ];
  #   };
  # };
}
