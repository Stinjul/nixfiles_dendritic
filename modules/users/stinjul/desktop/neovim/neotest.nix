{
  flake.modules.homeManager.user-stinjul-desktop = {
    programs.nixvim.plugins.neotest = {
      enable = true;
      adapters = {
        python = {
          enable = true;
        };
        elixir = {
          enable = true;
        };
        go = {
          enable = true;
        };
      };
    };
  };
}
