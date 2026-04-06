{
  flake.modules.homeManager.pywal = {
    home.persistence.main = {
      directories = [ ".cache/wal" ];
    };
  };
}
