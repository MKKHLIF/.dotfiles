{ config, pkgs, ... }:

{

  # environment.systemPackages = with pkgs;
  #   [ 
  #     (sddm-chili-theme.override {
  #       themeConfig = {
  #         background = config.stylix.image;
  #         ScreenWidth = 1920;
  #         ScreenHeight = 1080;
  #         blur = true;
  #         recursiveBlurLoops = 3;
  #         recursiveBlurRadius = 5;
  #       };})
  #   ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    # theme = "chili";
    package = pkgs.sddm;
  };
}
