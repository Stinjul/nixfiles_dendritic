{
  flake.modules.homeManager.firefox = {
    home.persistence.main = {
      directories = [
        ".config/mozilla/firefox"
      ];
    };
  };
}
