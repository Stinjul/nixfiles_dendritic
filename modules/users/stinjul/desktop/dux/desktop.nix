{
  inputs,
  self,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop-dux =
    {
      config,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        dux
      ];
      programs.dank-material-shell = {
        settings = {
          fontFamily = "Iosevka";
          monoFontFamily = "IosevkaTerm Nerd Font Mono";
          currentThemeName = "dynamic";
          currentThemeCategory = "dynamic";
          matugenSpec = "2025";
          matugenScheme = "scheme-tonal-spot";
          # matugenSeedColor = "#d5911a";

          springBounce = 0;
          motionEffect = 0;
          notificationShowTimeoutBar = true;

          bluetoothMprisEnabled = false;
          windSpeedUnit = "ms";
          useAutoLocation = true;
          clockFormat = "24h";
          firstDayOfWeek = 1;
          dashOptions = {
            media = {
              lyrics = false;
            };
          };

          cursorSettings = {
            theme = "Bibata-Modern-Classic";
            size = 24;
          };

          barConfigs = [
            {
              id = "default";
              name = "Main";
              enabled = true;
              position = 0;
              widgetStyle = "pills";
              barLengthMode = "full";
              leftWidgets = [
                "launcherButton"
                {
                  id = "workspaceSwitcher";
                  enabled = true;
                  showWorkspaceIndex = false;
                  showWorkspaceName = true;
                  workspaceIndicatorCompact = false;
                  workspaceIndicatorRoundness = -1;
                  workspaceIndicatorStyle = "pills";
                  showWorkspaceApps = false;
                  showOccupiedWorkspacesOnly = true;
                  showSpecialWorkspaces = false;
                }
                "focusedWindow"
              ];
              centerWidgets = [
                "music"
                "clock"
                "weather"
              ];
              rightWidgets = [
                "systemTray"
                "clipboard"
                "cpuUsage"
                "memUsage"
                "notificationButton"
                "battery"
                "controlCenterButton"
              ];
            }
          ];
        };
        session = {
          recentColors = [
            "#d5911a"
          ];

          materialWallpapers = {
            "" = {
              shared = {
                preset = "dank";
                seed = "#d5911a";
              };
              light = {
                preset = "dank";
                seed = "#d5911a";
              };
              dark = {
                preset = "dank";
                seed = "#d5911a";
              };
            };
          };

          timeLocale = "nl";
        };
      };
    };
}
