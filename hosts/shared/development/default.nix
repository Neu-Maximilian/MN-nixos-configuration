{ pkgs, ... }:

{
  # Python 3.12
  environment.systemPackages = with pkgs; [
    python312
  ];

}
