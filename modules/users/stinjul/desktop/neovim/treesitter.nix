{ moduleWithSystem, ... }:
{
  flake.modules.homeManager.user-stinjul-desktop = moduleWithSystem (
    { self', ... }:
    { config, ... }:
    {
      programs.nixvim = {
        plugins.treesitter = {
          enable = true;
          grammarPackages = config.programs.nixvim.plugins.treesitter.package.allGrammars ++ [
            self'.packages."tree-sitter-grammars/tree-sitter-irules"
          ];
          settings = {
            highlight = {
              enable = true;
            };
          };
          languageRegister.irules = "irules";
        };
        filetype.extension.irule = "irules";
        extraPlugins = [ self'.packages."tree-sitter-grammars/tree-sitter-irules" ];
      };
    }
  );
}
