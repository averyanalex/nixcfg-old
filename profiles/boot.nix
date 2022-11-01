{ lib, pkgs, config, ... }: {
  boot = {
    loader = {
      timeout = lib.mkForce 3;
    };
    kernelParams = [ "modeset" "nofb" ];

    kernelPackages = pkgs.linuxPackages_xanmod;

    consoleLogLevel = 3;
    kernel.sysctl."vm.swappiness" = 0;
    kernel.sysctl."kernel/sysrq" = 1;
  };

  persist.state.files = [ "/etc/machine-id" ];
}
