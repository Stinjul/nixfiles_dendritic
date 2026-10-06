{ pkgs }:
pkgs.writeShellScriptBin "omp-sandbox" ''
  set -euo pipefail

  project="$(realpath "$PWD")"

  exec ${pkgs.bubblewrap}/bin/bwrap \
      --die-with-parent \
      --new-session \
      \
      --unshare-user \
      --unshare-pid \
      --unshare-ipc \
      --unshare-uts \
      --unshare-cgroup \
      --disable-userns \
      \
      --hostname omp-sandbox \
      \
      --ro-bind /nix/store /nix/store \
      --ro-bind /run/current-system/sw /run/current-system/sw \
      \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --ro-bind /etc/static/ssl/certs /etc/ssl/certs \
      \
      --proc /proc \
      --dev /dev \
      --tmpfs /tmp \
      \
      --dir /run \
      --dir /var \
      --dir /home \
      --dir /home/omp \
      \
      --bind "$project" /workspace \
      \
      --bind "$HOME/.omp" /home/omp/.omp \
      \
      --chdir /workspace \
      \
      --setenv HOME /home/omp \
      --setenv USER omp \
      --setenv LOGNAME omp \
      --setenv TMPDIR /tmp \
      \
      --setenv TERM "''${TERM:-xterm-256color}" \
      \
      ${pkgs.omp}/bin/omp "$@"
''
