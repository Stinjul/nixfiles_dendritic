{
  inputs,
  ...
}:
{
  flake.modules.devenv.default = {
    git-hooks.hooks.commitizen.enable = true;
  };
}
