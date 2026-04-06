{
  flake.modules.nixos.k3s-cluster = {
    environment.persistence.main = {
      # I've seen people put logrotate in this but it wants to rename this file while updating it
      # Which doesn't work when it's a bind mount it seems
      # Don't think it's that important anyway, logs get killed after each reboot
      # files = [ "/var/lib/logrotate.status" ];
      directories = [
        "/etc/rancher"
        "/var/lib/rancher"
        "/var/lib/kubelet"
        "/var/lib/rook"
        "/var/lib/grafana-alloy"
        "/opt/cni"
        "/etc/cni"
      ];
    };
  };
}
