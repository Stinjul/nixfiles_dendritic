{
  flake.modules.homeManager.user-stinjul-nvim = {
    programs.nixvim = {
      autoCmd = [
        {
          command = "silent !Rscript -e \"rmarkdown::render('%', output_format = 'all')\"";
          event = [
            "BufWritePost"
          ];
          pattern = [
            "*.Rmd"
          ];
        }
      ];
    };
  };
}
