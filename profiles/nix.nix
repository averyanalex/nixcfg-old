{
  nix = {
    settings = {
      auto-optimise-store = true;

      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ "@users" ];
      trusted-users = [ "@wheel" ];

      experimental-features = "nix-command flakes";
    };
  };
}
