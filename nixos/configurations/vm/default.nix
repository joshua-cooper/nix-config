{
  imports = [
    ./boot.nix
    ./file-systems.nix
    ./users.nix
    ../../modules/environment
    ../../modules/systemd-resolved
    ../../modules/nix
    ../../modules/openssh
    ../../modules/fish
    ../../modules/home-manager
  ];

  system.stateVersion = "21.11";
}
