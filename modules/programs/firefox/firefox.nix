{
  flake.modules.homeManager.firefox =
    { pkgs, config, ... }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        package = pkgs.firefox.override {
          pkcs11Modules = [ pkgs.eid-mw ];
          nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
        };
      };
    };
}
