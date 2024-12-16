{ config, ... }:

{
    hardware.graphics.enable = true;
    hardware.nvidia = {
        prime = { 
            offload = {
                enable = true;
                enableOffloadCmd = true;
            };    
            # Make sure to use the correct Bus ID values for your system!
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
  };   
}
