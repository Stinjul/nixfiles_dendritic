{
  flake.modules.homeManager.rosec = {
    home.persistence.main = {
      directories = [ ".local/share/rosec" ];
    };
  };
}
