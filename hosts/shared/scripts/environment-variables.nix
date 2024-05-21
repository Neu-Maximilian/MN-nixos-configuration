{ pkgs, ... }:

{
  # Setup Env Variables
  environment.variables.JDK_PATH = "${pkgs.jdk11}/";
  environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";

  # environment.variables.CLIPBOARD_NOGUI = "1";
  # environment.variables.CLIPBOARD_NOPROGRESS = "1";
}
