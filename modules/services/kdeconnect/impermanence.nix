{
  flake.modules.homeManager.kdeconnect = {
    home.persistence.main = {
      directories = [ ".config/kdeconnect" ];
    };
  };
}
