{
  flake.modules.homeManager.discord = {
    home.persistence.main = {
      directories = [
        ".config/discord"
        ".config/Vencord"
      ];
    };
  };
}
