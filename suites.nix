{ utils }:
let
  nixosModules = utils.lib.exportModules [
    ./modules/clean-home.nix

    ./config/base-desktop.nix
    ./config/cli.nix
    ./config/personal.nix
    ./config/dev.nix
 ];

  sharedModules = with nixosModules; [
    # clean-home
    personal
   
   {
     home-manager.useGlobalPkgs = true;
     home-manager.useUserPackages = true;
   }
  ];

  desktopModules = with nixosModules; [
    base-desktop
    cli

    ({ pkgs, lib, config, ...}: {
      nix.generateRegistryFromInputs = true;
      nix.linkInputs = true;
      boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      nixpkgs.config.allowBroken = false;
      hardware.bluetooth.enable = true;
    })
  ];
in
{
  inherit nixosModules sharedModules desktopModules;
}