{ userSettings, systemSettings, ... }:

{
    networking.hostName = systemSettings.hostname;
    networking.networkmanager.enable = true;
    users.users.${userSettings.username}.extraGroups = [ "networkmanager" ];

    services.timesyncd.enable = true;

}
