{ pkgs
, ...
}: {
  fileSystems."data" = {
    mountPoint = "/data";
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "rw" "nofail" "users" ];
  };

  fileSystems."Ventoy" = {
    mountPoint = "/ventoy";
    device = "/dev/disk/by-label/Ventoy";
    fsType = "exfat";
    options = [ "rw" "nofail" "users" ];
  };
}
