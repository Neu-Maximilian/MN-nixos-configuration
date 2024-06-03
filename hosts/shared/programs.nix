{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    ventoy-full
  ];
}
