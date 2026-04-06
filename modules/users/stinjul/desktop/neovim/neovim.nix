{ moduleWithSystem, ... }:
{
  flake.modules.homeManager.user-stinjul-desktop = moduleWithSystem (
    { self', ... }:
    { pkgs, ... }:
    {
      programs.nixvim = {
        colorschemes.base16 = {
          enable = true;
          setUpBar = true;
          colorscheme = "schemer-dark";
        };

        globals = {
          mapleader = " ";
          maplocalleader = " ";
        };

        extraPlugins = with pkgs.vimPlugins; [
          self'.packages."vimPlugins/kcl-nvim"
          self'.packages."vimPlugins/vim-alloy"
          treesj
        ];

        extraConfigLua = ''
          require('treesj').setup({})
        '';

        clipboard = {
          providers.wl-copy.enable = true;
        };

        editorconfig.enable = true;

        plugins = {
          treesitter = {
            enable = true;
            settings = {
              highlight = {
                enable = true;
              };
            };
          };
          lualine = {
            enable = true;
          };
          gitsigns.enable = true;
          diffview.enable = true;
          neogit.enable = true;

          luasnip.enable = true;
          # surround.enable = true;

          coverage.enable = true;
          telescope.enable = true;
          trouble.enable = true;

          image.enable = true;
          markview = {
            enable = true;
            settings.preview = {
                icon_provider = "mini";
            };
          };

          mini = {
            enable = true;
            mockDevIcons = true;
            modules = {
              hipatterns = {
                highlighters.hex_color.__raw = ''require("mini.hipatterns").gen_highlighter.hex_color()'';
              };
              icons = { };
              indentscope = { };
              pairs = { };
              # splitjoin = { };
              surround = { };
            };
          };
        };
      };
    }
  );
}
