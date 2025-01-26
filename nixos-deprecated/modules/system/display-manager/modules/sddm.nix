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

  environment.systemPackages = [(
  pkgs.catppuccin-sddm.override {
    flavor = "mocha";
    font  = "Noto Sans";
    fontSize = "9";
    background = "${../../../../wallpapers/06.png}";
    loginBackground = true;
  }
  )];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
}
