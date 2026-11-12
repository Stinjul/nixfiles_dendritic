{
  lib,
  makeDesktopItem,
  copyDesktopItems,

  flutter347,
  fetchFromGitHub,
  zlib,
  runCommand,
  jdk,
}:

let
  zlib-root = runCommand "zlib-root" { } ''
    mkdir $out
    ln -s ${zlib.dev}/include $out/include
    ln -s ${zlib}/lib $out/lib
  '';
in
flutter347.buildFlutterApplication rec {
  pname = "trios";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "wispborne";
    repo = "TriOS";
    rev = version;
    hash = "sha256-x1yY03Cc4b4nj252BAgqnZhsii637SiAeYS82rzYt+0=";
    fetchSubmodules = true;
  };

  env.ZLIB_ROOT = zlib-root;

  nativeBuildInputs = [ copyDesktopItems ];

  buildInputs = [
    jdk
  ];

  pubspecLock = lib.importJSON ./pubspec.lock.json;
  gitHashes = {
    open_filex = "sha256-U6h3yAw0L7ZoQdviAz9YRuHBy9TwGVLQiRTH+Hl9R0g=";
    window_size = "sha256-Y113BPSxlNnera/3Dq2BYAX1YiGbCrVgJsfClnLNhjk=";
    irondash_engine_context = "sha256-uCmpMcIcqwaGkUEL7gzbM+5HGBpSXzOGw98XHI29EiM=";
  };

  postInstall = ''
    chmod +x $out/app/trios/data/flutter_assets/assets/linux/7zip/x64/7zzs
    install -Dm444 $out/app/trios/data/flutter_assets/assets/images/telos_faction_crest.png $out/share/icons/hicolor/128x128/apps/trios.png
    install -Dm444 $out/app/trios/data/flutter_assets/assets/images/telos_faction_crest.svg $out/share/icons/hicolor/scalable/apps/trios.svg
  '';

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = "TriOS";
      genericName = "Mod Manager";
      comment = "Starsector mod manager & toolkit.";
      exec = "TriOS";
      icon = "trios";
      categories = [ "Game" ];
      startupWMClass = pname;
    })
  ];
}
