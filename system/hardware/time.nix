{ systemSettings, ... }:

{
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  services.timesyncd.enable = true;
}
