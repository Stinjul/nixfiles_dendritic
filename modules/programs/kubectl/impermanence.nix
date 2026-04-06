{
  flake.modules.homeManager.kubectl = {
    home.persistence.main = {
      files = [ ".kube/config" ];
    };
  };
}
