{ pkgs, ... }: {
  # Enable Libvirtd
  virtualisation.libvirtd.enable = true;

  # Enable Waydroid

  # Enable Podman
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # nerdctl

    # firecracker
    # firectl
    # flintlock

    distrobox
    qemu

    podman-compose
    podman-tui

    virt-manager

    # lazydocker
    # docker-credential-helpers
  ];
}
