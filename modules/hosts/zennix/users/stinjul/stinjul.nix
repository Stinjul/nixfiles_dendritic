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
        rosec
      ];
      home-manager.users.stinjul =
        { config, lib, ... }:
        {
          imports = with inputs.self.modules.homeManager; [
            chromium
            mullvad
            android-tools
            rosec

            hyprland
            rofi
            quickshell

            vintagestory
            starsector

            llama-cpp
          ];
          home.stateVersion = "23.11";

          sops.defaultSopsFile = ./secrets.sops.yaml;
          services.rosec = {
            enable = true;
            settings = {
              autolock = {
                on_session_lock = true;
              };
              provider = [
                {
                  id = "local";
                  kind = "local";
                  # docs seem to be kinda wrong on this, toplevel path is the only option that sets the path correctly
                  # https://jmylchreest.github.io/rosec/configuration#provideroptions--local-vault-kind--local
                  # options.path = "${config.xdg.dataHome}/rosec/providers/local.vault";
                  path = "${config.xdg.dataHome}/rosec/providers/local.vault";
                }
              ];
            };
          };

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
