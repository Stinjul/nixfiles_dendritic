{
  flake.modules.nixos.zennix = {
    programs.ydotool.enable = true;
    users.users.stinjul.extraGroups = [ "ydotool" ];
  };
}
