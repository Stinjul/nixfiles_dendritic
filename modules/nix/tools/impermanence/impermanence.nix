{
  inputs,
  ...
}:
{
  flake.modules.nixos.impermanence =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.environment.persistence-activation;
    in
    {
      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];
      options = {
        environment.persistence-activation = {
          enable = lib.mkOption {
            description = "Toggle persistence";
            default = true;
            type = lib.types.bool;
          };
          wipeScripts.btrfs = {
            enable = lib.mkOption {
              description = ''
                Enables automatic cleaning of the btrfs root volume
                This script uses a modified version of the impermanence readme script and as such expects the root fs to be setup as described:
                https://github.com/nix-community/impermanence?tab=readme-ov-file#btrfs-subvolumes
                This script also assumes the root to be 'config.fileSystems."/".device', if this is somehow not the case use a custom script.
              '';
              default = false;
              type = lib.types.bool;
            };
            retention = {
              days = lib.mkOption {
                description = ''
                  How old an old root needs to be before it's removed in days.
                  Setting this to 0 will remove all old roots, not disable it.
                '';
                default = 30;
                type = lib.types.number;
              };
              atmost = lib.mkOption {
                description = ''
                  How many old roots to keep at most.
                  Setting this to 0 will remove all old roots, not disable it.
                '';
                default = 10;
                type = lib.types.number;
              };
            };
          };
        };
      };
      config = {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.impermanence
          { home.persistence = lib.mkIf (!cfg.enable) (lib.mkForce { }); }
        ];
        environment.persistence = lib.mkIf (!cfg.enable) (lib.mkForce { });

        # boot.initrd.postResumeCommands =
        boot.initrd.systemd = {
          services.wipe-root = {
            wantedBy = [ "initrd-root-device.target" ];
            wants = [ "lvm2-activation.service" ];
            after = [
              "lvm2-activation.service"
              "local-fs-pre.target"
            ];
            before = [ "sysroot.mount" ];
            unitConfig = {
              ConditionKernelCommandLine = [ "!resume=" ];
            };
            serviceConfig = {
              Type = "oneshot";
            };
            script =
              let
                wipeParams = cfg.wipeScripts.btrfs;
              in
              lib.throwIfNot (config.fileSystems."/".fsType == "btrfs")
                "Trying to use the btrfs wipescript on a non-btrfs filesystem is unsupported and probably a very bad idea!"
                (
                  lib.mkIf cfg.wipeScripts.btrfs.enable ''
                    mkdir /btrfs_tmp
                    mount ${config.fileSystems."/".device} /btrfs_tmp
                    if [[ -e /btrfs_tmp/root ]]; then
                        mkdir -p /btrfs_tmp/old_roots
                        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
                        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
                    fi

                    delete_subvolume_recursively() {
                        IFS=$'\n'
                        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                            delete_subvolume_recursively "/btrfs_tmp/$i"
                        done
                        btrfs subvolume delete "$1"
                    }

                    # Forgot we're in busybox, keeping this around for now
                    # cutoff=$(date -d '${toString wipeParams.retention.days} days ago' '+%Y-%m-%d_%H:%M:%S')

                    # mapfile -t dirs < <(find /btrfs_tmp/old_roots/ -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | sort)

                    # total=''${#dirs[@]}

                    # for idx in "''${!dirs[@]}"; do
                    #     dir="''${dirs[$idx]}"
                    #     
                    #     if [[ "$dir" < "$cutoff" || $idx -lt $((total - ${toString wipeParams.retention.atmost})) ]]; then
                    #         delete_subvolume_recursively "/btrfs_tmp/old_roots/$dir"
                    #     fi
                    # done

                    cutoff=$(date -d "@$(( $(date +%s) - ${toString wipeParams.retention.days}*24*60*60 ))" '+%Y-%m-%d_%H:%M:%S')

                    tmpfile="$(mktemp)"

                    find /btrfs_tmp/old_roots/ -maxdepth 1 -mindepth 1 -type d | \
                        while IFS= read -r path; do
                            printf '%s\n' "''${path##*/}"
                        done | sort > "$tmpfile"

                    total=$(wc -l < "$tmpfile")

                    idx=0

                    while IFS= read -r dir; do
                        if [ "$dir" \< "$cutoff" ] || [ "$idx" -lt $((total - ${toString wipeParams.retention.atmost})) ]; then
                            delete_subvolume_recursively "/btrfs_tmp/old_roots/$dir"
                        fi

                        idx=$((idx + 1))
                    done < "$tmpfile"

                    rm -f "$tmpfile"

                    btrfs subvolume create /btrfs_tmp/root
                    umount /btrfs_tmp
                  ''
                );
          };
        };
      };
    };

  # Checking for the existence of home.peristence
  flake.modules.homeManager.impermanence = {
    # Impermanence cannot be used on standalone HM anymore since v2 afaik, so not importing it by default
    # imports = [ inputs.impermanence.homeManagerModules.impermanence ];
  };
}
