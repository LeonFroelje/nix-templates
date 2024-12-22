terraform {
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
        }
    }
}

provider "proxmox" {
    insecure = true
    endpoint = var.pve_endpoint
 #   password = var.pve_password
    username = var.pve_username
    api_token = var.pve_api_token
    ssh {
        username = "root"
        agent = true
        password = var.pve_password
    }
}
