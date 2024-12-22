{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
    swapDevices = [];

    fileSystems."/" = { 
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
    };


    fileSystems."/boot" = { 
        device = "systemd-1";
        fsType = "autofs";
    };

}
