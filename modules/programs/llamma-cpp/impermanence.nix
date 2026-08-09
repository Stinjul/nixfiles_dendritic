{
  flake.modules.homeManager.llama-cpp = {
    home.persistence.main = {
      directories = [ ".llm"  ];
    };
  };
}
