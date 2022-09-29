{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/427a2dc1-f576-4e69-a439-5846acd44027";
    fsType = "ext4";
    options = [ "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FBC5-F521";
    fsType = "vfat";
  };

  fileSystems."/tank" = {
    device = "10.5.3.30:/tank";
    fsType = "nfs";
  };
}
