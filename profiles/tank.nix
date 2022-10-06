{
  boot.supportedFilesystems = [ "nfs" ];

  systemd.mounts = [{
    type = "nfs";
    mountConfig = {
      Options = "noatime";
    };
    what = "10.5.3.30:/tank";
    where = "/tank";
    after = [ "nebula@averyan.service" ];
    wants = [ "nebula@averyan.service" ];
  }];

  systemd.automounts = [{
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "600";
    };
    where = "/tank";
  }];
}
