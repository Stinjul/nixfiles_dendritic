{ inputs, ... }:
{
  flake.modules.nixos.hyprland = {
    programs.hyprland.enable = true;
  };
  flake.modules.homeManager.hyprland =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        wayland
      ];
      wayland.windowManager.hyprland = {
        enable = true;
      };
      xdg.portal = {
        extraPortals = [
          pkgs.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal-gtk
        ];
        configPackages = [ pkgs.hyprland ];
      };

      services.hyprpolkitagent.enable = lib.mkDefault true;
    };
}
