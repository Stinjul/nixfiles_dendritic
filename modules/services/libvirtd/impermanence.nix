{
  flake.modules.nixos.libvirtd = {
    environment.persistence.main = {
      directories = [ "/var/lib/libvirt" ];
    };
  };
}
