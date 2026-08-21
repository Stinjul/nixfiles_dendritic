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

            llama-cpp
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
            workspace_rule = lib.concatMap (ws: [
              {
                workspace = ws;
                monitor = "DP-3";
              }
              {
                workspace = ws;
                monitor = "DP-2";
              }
            ]) (lib.range 1 10);
            monitor = map (m: {
              output = m.name;
              mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
              position = "${toString m.x}x${toString m.y}";
              transform = ((builtins.div m.rotate 90) + (if m.flipped then 4 else 0));
            }) (config.monitors);
          };
        };
    };
}
