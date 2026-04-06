{
  flake.modules.homeManager.hyprland = {
    home.persistence.main = {
      directories = [ ".local/share/hyprland"  ];
    };
  };
}
