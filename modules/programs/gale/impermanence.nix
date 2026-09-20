{
  flake.modules.homeManager.gale = {
    home.persistence.main = {
      directories = [
        ".config/com.kesomannen.gale"
        ".local/share/com.kesomannen.gale/"
      ];
    };
  };
}
