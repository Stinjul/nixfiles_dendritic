{ inputs, ... }:
{
  flake.modules.homeManager.mpd-standalone =
    {
      config,
      ...
    }:
    {
      services = {
        mpd = {
          enable = true;
          musicDirectory = "${config.home.homeDirectory}/Music";
          dataDir = "${config.xdg.dataHome}/mpd";
          extraConfig = ''
            auto_update "yes"
            restore_paused "yes"
            audio_output {
                type                    "fifo"
                name                    "local_fifo"
                path                    "/tmp/mpd.fifo"
                format                  "44100:16:2"
            }
          '';
        };
        mpd-mpris = {
          enable = true;
          mpd.useLocal = true;
        };
      };
    };
  flake.modules.homeManager.mpd =
    {
      osConfig,
      lib,
      ...
    }:
    {
      imports = [ inputs.self.modules.homeManager.mpd-standalone ];
      services.mpd.extraConfig = builtins.concatStringsSep "\n" (
        [
        ]
        ++ lib.optional osConfig.services.pipewire.enable ''
          audio_output {
            type            "pipewire"
            name            "PW Audio"
          }
        ''
      );

    };
}
