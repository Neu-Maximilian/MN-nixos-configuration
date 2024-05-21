{ ... }:

{
  # Display Manager ----------
  # Enable Greetd
  /*
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
      };
      default_session = initial_session;
    };
  };
  */

  # Enable sddm for wayland
  #services.xserver.displayManager.sddm = {
  #  enable = true;
  #  wayland.enable = true;
  #};
}
