{
  flake.modules.nixos.tuigreet = {
    environment.persistence.main = {
      # This was for https://github.com/apognu/tuigreet, the NotAShelf fork moved it
      # directories = [ "/var/lib/tuigreet" ];
      directories = [ "/var/cache/tuigreet" ];
    };
  };
}
