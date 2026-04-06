{
  xivlauncher,
  steam,
  gamemode,
}:
xivlauncher.override {
  steam = steam.override { extraLibraries = pkgs: [ gamemode.lib ]; };
}
