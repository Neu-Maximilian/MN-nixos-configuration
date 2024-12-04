{ config, pkgs, ... }:

{
  imports = [
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # System Administration
    powertop # Power management
    btop # System monitor
    ncdu # Analyze disk usage 
    virt-viewer # Virtual machine viewer
    starship # Shell prompt
    openssl # SSL/TLS toolkit
    nixpkgs-fmt # Nix code formatter

    # Media editing
    audacity # audio
    libsForQt5.kdenlive # video editor
    olive-editor # new and promising video editor
    obs-studio # recording
    gimp # image editor
    rawtherapee # RAW image editor
    ocrmypdf

    # Office
    libreoffice
    zathura
    thunderbird
    scribus

    # Windows
    wineWowPackages.stable
    winetricks

    # Graphics
    mesa-demos # opengl and lots of tests

    # Browsers
    floorp
    google-chrome

    # Code editors
    vscode-fhs
    github-desktop

    # Networking
    ciscoPacketTracer8
    wireshark

    # Security
    keepassxc
  ];
}
