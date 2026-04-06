{
  flake.modules.homeManager.chromium = {
    home.persistence.main = {
      directories = [
        ".config/chromium"
      ];
    };
  };
}
