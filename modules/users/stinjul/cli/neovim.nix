{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-cli = {
    imports = with inputs.self.modules.homeManager; [
      neovim
    ];
  };
}
