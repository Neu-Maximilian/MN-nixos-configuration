{ config, pkgs, ... }:

let
  zammadDbPasswordFile = "/etc/zammad/db_password"; # openssl rand -hex 22 | sudo tee -a /etc/zammad/db_password >> /dev/null && sudo chown zammad:zammad /etc/zammad/db_password && sudo chmod 600 /etc/zammad/db_password
  zammadSecretFile = "/etc/zammad/secret_key_base_file"; # openssl rand -hex 64 | sudo tee -a /etc/zammad/secret_key_base_file >> /dev/null && sudo chown zammad:zammad /etc/zammad/secret_key_base_file && sudo chmod 600 /etc/zammad/secret_key_base_file
  zammadDbPassword = builtins.readFile zammadDbPasswordFile;
in
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_12; # Use the appropriate version
    dataDir = "/var/lib/postgresql/12/zammad";
    authentication = '' # Add this to allow password authentication
      local   all             postgres                                peer
      local   all             zammad_user                             md5
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

    host = "127.0.0.1";
    port = 3000;
    websocketPort = 6042;

    dataDir = "/var/lib/zammad";

    # Redis configuration
    redis = {
      host = "localhost";
      port = 6379;
      name = "zammad-redis";
      createLocally = true;
    };

    # Database configuration
    database = {
      port = 5432;
      host = "/run/postgresql";
      name = "zammad";
      user = "zammad_user";
      type = "PostgreSQL";
      passwordFile = zammadDbPasswordFile;
      createLocally = false;
    };

    secretKeyBaseFile = zammadSecretFile;

    openPorts = true;
  };

  # Ensure the required files are in place
  systemd.tmpfiles.rules = [
    "d /var/lib/zammad 0755 zammad zammad -"
    "f /etc/zammad/db_password 0600 zammad zammad -"
    "f /etc/zammad/secret_key_base_file 0600 zammad zammad -"
  ];

  users.users.zammad_user = {
    isSystemUser = true;
    group = "zammad";
  };

  users.groups.zammad = { };
}
