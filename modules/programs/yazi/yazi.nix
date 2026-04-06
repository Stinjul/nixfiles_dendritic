{
  flake.modules.homeManager.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        shellWrapperName = "y";
        plugins = {
          git = pkgs.yaziPlugins.git;
        };
        initLua = ./yazi.lua;
        settings = {
          plugin.prepend_fetchers = [
            {
              id = "git";
              url = "*";
              run = "git";
            }
            {
              id = "git";
              url = "*/";
              run = "git";
            }
          ];
        };
        keymap = {
          mgr.prepend_keymap = [
            {
              on = "!";
              run = "shell \"$SHELL\" --block";
              desc = "open shell here";
            }
          ];
        };
      };
    };
}
