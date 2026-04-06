{
  flake.modules.nixos.bluetooth = {
    environment.persistence.main = {
      directories = [ "/var/lib/bluetooth" ];
    };
  };
}
