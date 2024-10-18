{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    ventoy-full
    dmg2img
    krdc
  ];
}
