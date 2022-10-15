{
  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    config = {
      Peers = [
        "tls://ygg.averyan.ru:8362"
      ];
      IfName = "ygg0";
    };
  };

  systemd.services.yggdrasil.wants = [ "systemd-tmpfiles-setup.service" ];
  systemd.services.yggdrasil.after = [ "systemd-tmpfiles-setup.service" ];

  persist.state.dirs = [ "/var/lib/yggdrasil" ];
}
