{
  flake.modules.homeManager.firefox = {
    home.persistence.main = {
      directories = [
        ".mozilla/firefox"
      ];
    };
  };
}
