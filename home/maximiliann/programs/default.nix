{ config, pkgs, ... }:

{
  imports = [
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # System Administration
    powertop      # Power management
    btop          # System monitor
    ncdu          # Analyze disk usage 
    virt-viewer   # Virtual machine viewer

    # Media editing
    audacity            # audio
    libsForQt5.kdenlive # video editor
    olive-editor        # new and promising video editor
    obs-studio          # recording
    gimp   # image editor
    rawtherapee         # RAW image editor

    # Gaming
    steam
    wineWowPackages.stable
    winetricks
    # Games
    osu-lazer

    # Graphics
    mesa-demos          # opengl and lots of tests
    
    # Browsers
    firefox
    ungoogled-chromium

    # Code editors
    vscode-fhs
 ];
}
