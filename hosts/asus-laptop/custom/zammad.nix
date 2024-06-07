{ config, pkgs, ... }:

let
  zammadDbPassword = "your-database-password"; # Replace with a secure password
in
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_12; # Use the appropriate version
    dataDir = "/var/lib/postgresql";
    authentication = '' # Add this to allow password authentication
      local   all             postgres                                peer
      host    all             all             127.0.0.1/32            md5
      host    all             all             ::1/128                 md5
    '';
    initialScript = pkgs.writeText "init.sql" ''
      CREATE DATABASE zammad;
      CREATE USER zammad_user WITH PASSWORD '${zammadDbPassword}';
      GRANT ALL PRIVILEGES ON DATABASE zammad TO zammad_user;
    '';
  };

  services.zammad = {
    enable = true;
    package = pkgs.zammad;

    host = "0.0.0.0";
    port = 3000;
    websocketPort = 6042;

    dataDir = "/var/lib/zammad";

    # Redis configuration
    redis = {
      host = "127.0.0.1"; # Assuming Redis is local
      port = 6379;
      name = "zammad-redis";
      createLocally = true;
    };

    # Database configuration
    database = {
      host = "127.0.0.1";
      port = 5432;
      name = "zammad";
      user = "zammad_user";
      type = "postgresql";
      settings = {
        pool = 5;
        timeout = 5000;
      };
      passwordFile = "/etc/zammad/db_password";
      createLocally = false;
    };

    secretKeyBaseFile = "/etc/zammad/secret_key_base";

    openPorts = true;
  };

  # Ensure the required files are in place
  systemd.tmpfiles.rules = [
    "d /var/lib/zammad 0755 zammad zammad -"
    "f /etc/zammad/secret_key_base 0600 root root -"
    "f /etc/zammad/db_password 0600 root root -"
  ];

  users.users.zammad = {
    isSystemUser = true;
    group = "zammad";
  };

  users.groups.zammad = {};

  # Example of how to specify the contents of the secret_key_base file and db_password file
  environment.etc = {
    "zammad/secret_key_base" = {
      text = ''your-secret-key-base'';
      mode = "0600";
      owner = "root";
      group = "root";
    };
    "zammad/db_password" = {
      text = "${zammadDbPassword}";
      mode = "0600";
      owner = "root";
      group = "root";
    };
  };
}
