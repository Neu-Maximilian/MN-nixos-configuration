{ pkgs
, ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."maximiliann" = {
    isNormalUser = true;
    description = "maximiliann's account";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "tss" "libvirtd" "adbusers" ];
    shell = pkgs.fish;
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
