{
  flake.modules.homeManager.fish = {
    home.persistence.main = {
      directories = [
        ".config/fish"
        ".local/share/fish"
      ];
    };
  };
}
