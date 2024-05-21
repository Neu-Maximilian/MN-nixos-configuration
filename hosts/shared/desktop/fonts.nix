{ nixpkgs-stable, ... }:

{
  # Fonts
  fonts.packages = with nixpkgs-stable; [
    jetbrains-mono
    nerd-font-patcher
  ];
}
