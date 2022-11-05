{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  users.users.javi = {
    isNormalUser = true;
    home = "/home/javi";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$fPOECXjA$A0e5ZGA0eLN5mNIaPFMVNgDel6mg2QmMkGDkTnju7cxNBeHdE4nuUoaMix4EsR6v7j6dHwf85jYVtnFHZ4Exh.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHp6dKtRhODtSuyPY4BGazSz81avxxqUm3bv+lLZuMVo javi@MacBook-Pro.home.campalus.com"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix)
  ];
}
