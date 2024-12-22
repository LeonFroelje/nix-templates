resource "proxmox_virtual_environment_vm" "template" {
    vm_id = 1
    name = "template"
    node_name = "pve"

   agent {
        enabled = false
    }

    cpu {
        cores = 1
        type = "host"
    }
    
    memory {
        dedicated = 2048
    }
    
    disk {
        datastore_id = "nvme-mirror"
        file_id = proxmox_virtual_environment_file.template_image.id
        interface = "scsi0"
        discard = "on"
    }

    network_device {
        bridge = "vmbr101"
        vlan_id = 40
    }
}

resource "proxmox_virtual_environment_file" "template_image" {
    content_type = "iso"
    datastore_id = "isos"
    node_name = "pve"
    overwrite = true
    source_file {
        # path = "/nix/store/6pfim28qx2h977dv1f5dgrka1c1rgss7-nixos-disk-image/nixos.qcow2"
        file_name = "template.img"
    }
}

