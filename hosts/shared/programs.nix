{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
    ventoy-web
  ];
}
