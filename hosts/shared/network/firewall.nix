{...}: {
  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22000 51820];
    allowedUDPPorts = [22000 51820];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
