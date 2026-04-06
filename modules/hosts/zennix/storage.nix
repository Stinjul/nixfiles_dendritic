{
  lib,
  ...
}:
{
  flake.modules.nixos.zennix =
    {
      config,
      ...
    }:
    {
      fileSystems."/persist".neededForBoot = true;
      environment.persistence-activation.wipeScripts.btrfs = {
        enable = true;
        retention = {
          days = 10;
          atmost = 10;
        };
      };

      # boot.initrd.postDeviceCommands = lib.mkAfter ''
      #   mkdir /btrfs_tmp
      #   mount ${config.fileSystems."/".device} /btrfs_tmp
      #   if [[ -e /btrfs_tmp/root ]]; then
      #       mkdir -p /btrfs_tmp/old_roots
      #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
      #       mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      #   fi

      #   delete_subvolume_recursively() {
      #       IFS=$'\n'
      #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
      #           delete_subvolume_recursively "/btrfs_tmp/$i"
      #       done
      #       btrfs subvolume delete "$1"
      #   }

      #   # for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
      #   for i in $(find /btrfs_tmp/old_roots/ -mindepth 1 -maxdepth 1 | head -n -10); do
      #       delete_subvolume_recursively "$i"
      #   done

      #   btrfs subvolume create /btrfs_tmp/root
      #   umount /btrfs_tmp
      # '';

      disko.devices = {
        disk = {
          ssd_boot = {
            type = "disk";
            device = "/dev/disk/by-path/pci-0000:01:00.0-nvme-1";
            content = {
              type = "gpt";
              partitions = {
                BOOT = {
                  priority = 1;
                  size = "16G";
                  type = "EF00";
                  label = "BOOT";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [
                      "fmask=0022"
                      "dmask=0022"
                    ];
                  };
                };
                lvm = {
                  size = "100%";
                  content = {
                    type = "lvm_pv";
                    vg = "ssd_boot";
                  };
                };
              };
            };
          };
          ssd_data = {
            type = "disk";
            device = "/dev/disk/by-path/pci-0000:04:00.0-nvme-1";
            content = {
              type = "lvm_pv";
              vg = "ssd_data";
            };
          };
          hdd_data = {
            type = "disk";
            device = "/dev/disk/by-path/pci-0000:04:00.0-nvme-1";
            content = {
              type = "gpt";
              partitions = {
                zentoo_data = {
                  size = "2621000M";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                  };
                };
                lvm = {
                  size = "1194446M";
                  content = {
                    type = "lvm_pv";
                    vg = "hdd_data";
                  };
                };
              };
            };
          };
        };
        lvm_vg = {
          ssd_boot = {
            type = "lvm_vg";
            lvs = {
              zennix_root = {
                size = "16G";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                    };
                  };
                };
              };
              nixos_persist = {
                size = "256G";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/persist";
                };
              };
            };
          };
          ssd_data = {
            type = "lvm_vg";
            lvs = {
              zennix_nix_store = {
                size = "256G";
                content = {
                  type = "btrfs";
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
              steam_library = {
                size = "1T";
                content = {
                  type = "filesystem";
                  format = "xfs";
                  mountpoint = "/mnt/steam_library";
                };
              };
            };
          };
          hdd_data = {
            type = "lvm_vg";
            lvs = {
              steam_library = {
                size = "1T";
                content = {
                  type = "btrfs";
                  mountpoint = "/mnt/hdd_steam_library";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
}
