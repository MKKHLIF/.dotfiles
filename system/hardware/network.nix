{ userSettings, ... }:

{
    networking.networkmanager.enable = true;
    users.users.${userSettings.username}.extraGroups = [ "networkmanager" ];
}
