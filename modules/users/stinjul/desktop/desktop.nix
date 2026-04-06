{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.user-stinjul-desktop = {
    imports = with inputs.self.modules.nixos; [
      steam
    ];
    security.pam.loginLimits = [
      {
        domain = "stinjul";
        item = "nofile";
        type = "-";
        value = "1048576";
      }
    ];
  };
  flake.modules.homeManager.user-stinjul-desktop =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        vesktop
        kdeconnect
        mpd
        mpv
        qt
        r2modman
        remmina
        xivlauncher
        prismlauncher
        termfilechooser
      ];
      home = {
        packages = with pkgs; [
          yubioath-flutter
          yubikey-manager
          yubikey-personalization

          coppwr
          pavucontrol

          yt-dlp
          ffmpeg-full
          eid-mw
        ];
        persistence.main = {
          files = [ ".config/sops/age/keys.txt" ];
        };
      };
      sops = {
        age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        secrets = {
          ssh_key_25_809_123.sopsFile = ./secrets.sops.yaml;
          ssh_key_25_809_126.sopsFile = ./secrets.sops.yaml;
        };
      };
      xdg.portal.termfilechooser = {
        enable = true;
        settings = {
          filechooser = {
            cmd = "${config.xdg.portal.termfilechooser.package}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";
            env = "TERMCMD=${config.home.sessionVariables.TERMINAL}";
            default_dir = "$HOME";
          };
        };
      };
    };
}
