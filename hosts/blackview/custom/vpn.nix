{ pkgs, ... }:
let
  # Import the TOML file
  configTaki = builtins.fromTOML (builtins.readFile "/etc/nixos/.secrets/wireguard-client-taki.toml");
in
{
  # Enable WireGuard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "192.168.27.67/32" ];
      listenPort = 51821; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      privateKey = configTaki.PrivateKey;

      peers = [
        # For a client configTakiuration, one peer entry for the server will suffice.
        {
          # Public key of the server (not a file path).
          publicKey = configTaki.PublicKey;

          # Pre-shared key
          presharedKey = configTaki.PresharedKey;

          # Forward all the traffic via VPN.
          # allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          allowedIPs = [
            "192.168.0.0/24"
          ];

          # Set this to the server IP and port.
          endpoint = configTaki.Endpoint; 
          
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
