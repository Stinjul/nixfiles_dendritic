{
  flake.modules.homeManager.prismlauncher = {
    home.persistence.main = {
      directories = [ ".local/share/PrismLauncher"  ];
    };
  };
}
