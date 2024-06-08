{ ... }:

{
  # Nix Configuration
  # Enable experimental features
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
