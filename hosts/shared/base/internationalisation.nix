{
  pkgs,
  ...
}: {
  # Select internationalisation properties.
  services.xserver = {
    xkb.layout = "us";
    xkb.options = "grp:alt_shift_toggle";
  };

  i18n = {
    supportedLocales = [
      "en_US.utf8"
      #"fr_FR.utf8"
    ];

    defaultLocale = "en_US.utf8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.utf8";
      LC_IDENTIFICATION = "en_US.utf8";
      LC_MEASUREMENT = "en_US.utf8";
      LC_MONETARY = "en_US.utf8";
      LC_NAME = "en_US.utf8";
      LC_NUMERIC = "en_US.utf8";
      LC_PAPER = "en_US.utf8";
      LC_TELEPHONE = "en_US.utf8";
      LC_TIME = "en_US.utf8";
    };
  };
}
