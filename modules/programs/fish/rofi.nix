{
  flake.modules.homeManager.fish = {
    programs.rofi = {
      extraConfig = {
        run-command = "fish -c '{cmd}'";
        run-list-command = "fish -c functions";
      };
    };
  };
}
