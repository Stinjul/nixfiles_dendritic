{
  flake.modules.homeManager.mpd = {
    home.persistence.main = {
      directories = [ ".local/share/mpd" ];
    };
  };
}
