{
  flake.modules.homeManager.llama-cpp =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.llama-cpp-vulkan ];
    };

}
