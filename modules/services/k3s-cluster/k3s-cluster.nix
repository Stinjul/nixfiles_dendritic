{ inputs, ... }:
{
  flake.modules.nixos.k3s-cluster =
    { config, lib, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        k3s
      ];
      services.k3s = {
        enable = true;
        role = lib.mkDefault "server";
        extraFlags = [
          "--disable local-storage"
          "--disable metrics-server"
          "--disable traefik"
          "--disable servicelb"
          "--flannel-backend=none"
          "--disable-network-policy"
          "--disable-helm-controller"
          "--disable-kube-proxy"
          "--etcd-expose-metrics"
          "--node-name ${config.networking.hostName}"
        ];
      };
    };
}
