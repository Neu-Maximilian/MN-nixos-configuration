{
  pkgs,
  username,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}'s account";
    extraGroups = ["networkmanager" "input" "wheel" "video" "audio" "tss" "libvirtd" "adbusers"];
    shell = pkgs.fish;
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
