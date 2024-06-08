{ pkgs
, ...
}: {
  # Select internationalisation properties.
  services.xserver = {
    xkb.layout = "us";
    xkb.options = "grp:alt_shift_toggle";
  };

  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];

    defaultLocale = "en_US.UTF-8";
  };
}
