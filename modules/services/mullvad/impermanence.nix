{
  flake.modules.nixos.mullvad = {
    environment.persistence.main = {
      directories = [ "/etc/mullvad-vpn" ];
    };
  };

  flake.modules.homeManager.mullvad = {
    home.persistence.main = {
      directories = [ ".config/Mullvad VPN" ];
    };
  };
}
