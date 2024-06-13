{ pkgs
, ...
}:
let

  wordpress-theme-responsive = pkgs.stdenv.mkDerivation rec {
    name = "responsive";
    version = "4.7.9";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/theme/responsive.${version}.zip";
      hash = "sha256-7K/pwD1KAuipeOAOLXd2wqOUEhwk+uNGIllVWzDHzp0=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

in
{
  # Custom themes and plugins
  services.wordpress.sites."localhost" = {
    themes = {
      inherit (pkgs.wordpressPackages.themes)
        twentytwentythree
        twentytwentyone;
      inherit wordpress-theme-responsive;
    };
    extraConfig = ''
      define('FS_METHOD', 'direct');
    '';
    # plugins = {
    #   inherit (pkgs.wordpressPackages.plugins)
    #     antispam-bee
    #     opengraph;
    # };
  };
}
