{ config, lib, pkgs, sshKeys, ... }:
{
    boot.loader.grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
    };
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "de_DE.UTF-8";
    
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
      };
    console.keyMap = "de";
    nix.settings.trusted-users = [
        "leon"
    ];
    users.users."leon" = {
        isNormalUser = true;
        description = "leon";
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keyFiles = [
            sshKeys.outPath
        ];
    };
    security.sudo.extraRules = [
      { users = [ "leon" ];
        commands = [
            { command = "ALL"; options = [ "NOPASSWD" ];}
        ];
      }
    ];

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = false;
            AllowUsers = [ "leon" ];
            PermitRootLogin = "no";
            KbdInteractiveAuthentication = false;
        };
    };

    
    services.getty.autologinUser = "leon";
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.05";
}
