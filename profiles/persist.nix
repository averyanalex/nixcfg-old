{
  persist = {
    enable = true;
    state = {
      directories = [
        "/var/log"
        "/var/lib"
        "/home"
      ];
    };
  };

  fileSystems."/etc/ssh" = {
    depends = [ "/persist" ];
    neededForBoot = true;
  };
}
