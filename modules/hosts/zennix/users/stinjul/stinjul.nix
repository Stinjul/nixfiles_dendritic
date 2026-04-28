{
  inputs,
  ...
}:
{
  flake.modules.nixos.zennix =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        user-stinjul-desktop
        hyprland
        yubikey-touch-detector
      ];
      home-manager.users.stinjul =
        { config, lib, ... }:
        {
          imports = with inputs.self.modules.homeManager; [
            chromium
            mullvad
            android-tools

            hyprland
            rofi
            quickshell

            vintagestory
            starsector

            lmstudio
          ];
          home.stateVersion = "23.11";

          sops.defaultSopsFile = ./secrets.sops.yaml;
          home = {
            packages = with pkgs; [
              winbox
              krita
            ];
            persistence.main = {
              directories = [
                "Work"
              ];
            };
          };
          wayland.windowManager.hyprland.settings = {
            workspace = map (w: "${toString w}, monitor:DP-2,monitor:DP-3") (lib.range 1 10);
            monitor = map (
              m:
              "${m.name}, ${
                if m.enabled then
                  "${toString m.width}x${toString m.height}@${toString m.refreshRate}, ${toString m.x}x${toString m.y}, 1"
                else
                  "disable"
              }, transform, ${toString ((builtins.div m.rotate 90) + (if m.flipped then 4 else 0))}"
            ) (config.monitors);
          };
        };
    };
}
