{ pkgs, ... }:
let
  # Import the TOML file
  configTaki = builtins.fromTOML (builtins.readFile "/etc/nixos/.secrets/wireguard-client-taki.toml");
  # configNico = builtins.fromTOML (builtins.readFile "/etc/nixos/.secrets/wireguard-client-nico.toml");
in
{
  # Enable WireGuard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      # Get this from a secret file in .secrets/wireguard-client.toml

      ips = configTaki.ips;
      listenPort = 51821; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKey = configTaki.privateKey;

      peers = [
        # For a client configTakiuration, one peer entry for the server will suffice.

        {
          # Public key of the server (not a file path).
          publicKey = configTaki.publicKey;

          # Pre-shared key
          presharedKey = configTaki.presharedKey;

          # Forward all the traffic via VPN.
          # allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          allowedIPs = configTaki.allowedIPs;

          # Set this to the server IP and port.
          endpoint = configTaki.endpoint; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
    # wg1 = {
    #   ips = configNico.ips;
    #   listenPort = 51820;
    #   privateKey = configNico.privateKey;
    #   peers = [
    #     {
    #       publicKey = configNico.publicKey;
    #       presharedKey = configNico.presharedKey;
    #       allowedIPs = configNico.allowedIPs;
    #       endpoint = configNico.endpoint;
    #       persistentKeepalive = 25;
    #     }
    #   ];
    # };
  };
}
