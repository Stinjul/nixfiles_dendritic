{
  flake.modules.nixos.gtk = {
    programs.dconf.enable = true;
  };
  flake.modules.homeManager.gtk = {
    gtk = {
      enable = true;
    };
  };
}
