{
  flake.modules.homeManager.remmina = {
    home.persistence.main = {
      directories = [
        ".config/remmina"
        ".local/share/remmina"
      ];
    };
  };
}
