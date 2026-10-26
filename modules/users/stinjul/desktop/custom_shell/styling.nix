{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop-custom = {
    imports = with inputs.self.modules.homeManager; [
      pywal
    ];
  };
}
