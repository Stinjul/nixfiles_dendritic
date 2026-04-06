{
  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
          pkcs11Modules = [ pkgs.eid-mw ];
          nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
        };
      };
    };
}
