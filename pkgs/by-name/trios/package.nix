{
  flutter338,
  # sentry-native,
  fetchFromGitHub,
  lib,
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
flutter338.buildFlutterApplication rec {
  pname = "trios";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "wispborne";
    repo = "TriOS";
    rev = version;
    hash = "sha256-q1Bt2OwUyMWtlN6hM3a1+px64l2L4pi+VAJjKqZIQ0g=";
    fetchSubmodules = true;
  };

  env.ZLIB_ROOT = zlib-root;

  buildInputs = [
    jdk
  ];

  pubspecLock = lib.importJSON ./pubspec.lock.json;
  gitHashes = {
    open_filex = "sha256-U6h3yAw0L7ZoQdviAz9YRuHBy9TwGVLQiRTH+Hl9R0g=";
    window_size = "sha256-Y113BPSxlNnera/3Dq2BYAX1YiGbCrVgJsfClnLNhjk=";
  };

  postInstall = ''
    chmod +x $out/app/trios/data/flutter_assets/assets/linux/7zip/x64/7zzs
  '';
}
