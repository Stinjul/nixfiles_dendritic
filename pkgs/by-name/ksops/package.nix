{
  kustomize-sops,
}:
(kustomize-sops.overrideAttrs (prev: {
  installPhase = ''
    mkdir -p $out/bin
    mv $GOPATH/bin/kustomize-sops $out/bin/ksops
  '';
}))
