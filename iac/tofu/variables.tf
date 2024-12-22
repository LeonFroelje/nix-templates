variable "pve_endpoint" {
    type = string
    description = "Endpoint for PVE machine to manage"
}

variable "pve_password" {
    type = string
    description = "Password/Auth token for user on PVE machine"
}

variable "pve_username" {
    type = string
    description = "Username and realm for PVE user"
}

variable "pve_api_token" {
    type = string
    description = "API Token for PVE"
}
