{ moduleWithSystem, ... }:
{
  flake.modules.homeManager.kubectl = moduleWithSystem (
    { self', ... }:
    { pkgs, ... }:
    {
      home.packages =
        (with pkgs; [
          # https://github.com/NixOS/nixpkgs/issues/490442
          argocd
          kustomize
          # ksops
          k3s
          kubernetes-helm
          # kustomize-kcl
        ])
        ++ (with self'.packages; [
          ksops
          kustomize-kcl
        ]);
    }
  );
}
