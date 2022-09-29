let
  alex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINF5KDy1T6Z+RlDb+Io3g1uSZ46rhBxhNE39YlG3GPFM";
  users = [ alex ];

  eagle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdFLG40/W62LpwPK0PQUSr/3zGNAn5qK4jabXDl9SIM";
  rat = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIo9EB6kxVzY93JU602tDaEYwmo4+V8d5xoYS3c1+aN";
  proxies = [ eagle rat ];

  alligator = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE7y1Vw/aeF69RDccAB2BB1IATUvVEQ7sIgAO5fUZKyC";
  hamster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICN/Mu9oGr3VFS+GMBNPASaoMyiMO1G8T4fUKjJJpy30";
  desktops = [ alligator hamster ];

  whale = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtyxNV8IPSMHudJrMbemcK82LosU9tdNDV2rhf0Z9ps";
  seal = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZex80XRSmrxM3iz1s55cVJGiSes7MZaESxurjscoW8";
  servers = [ whale seal ];

  systems = proxies ++ desktops ++ servers;
in
{
  "secrets/passwords/alex.age".publicKeys = users ++ systems;

  "secrets/nebula/ca-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/ca-key.age".publicKeys = users;
  "secrets/nebula/eagle-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/eagle-key.age".publicKeys = users ++ [ eagle ];
  "secrets/nebula/rat-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/rat-key.age".publicKeys = users ++ [ rat ];
  "secrets/nebula/alligator-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/alligator-key.age".publicKeys = users ++ [ alligator ];
  "secrets/nebula/hamster-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/hamster-key.age".publicKeys = users ++ [ hamster ];
  "secrets/nebula/whale-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/whale-key.age".publicKeys = users ++ [ whale ];
  "secrets/nebula/seal-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/seal-key.age".publicKeys = users ++ [ seal ];

  "secrets/nebula-frsqr/ca-crt.age".publicKeys = users ++ systems;
  "secrets/nebula-frsqr/whale-crt.age".publicKeys = users ++ systems;
  "secrets/nebula-frsqr/whale-key.age".publicKeys = users ++ [ whale ];
  "secrets/nebula-frsqr/hamster-crt.age".publicKeys = users ++ systems;
  "secrets/nebula-frsqr/hamster-key.age".publicKeys = users ++ [ hamster ];
  "secrets/nebula-frsqr/alligator-crt.age".publicKeys = users ++ systems;
  "secrets/nebula-frsqr/alligator-key.age".publicKeys = users ++ [ alligator ];
}
