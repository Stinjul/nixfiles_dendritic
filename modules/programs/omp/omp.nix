{
  moduleWithSystem,
  ...
}:
{
  flake.modules.homeManager.omp = moduleWithSystem (
    { self', ... }:
    {
      home.packages = [ self'.packages.omp-sandbox ];
    }
  );
}
