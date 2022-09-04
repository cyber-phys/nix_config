{
  description = "Luc's nix configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    unstable.follows = "nixpkgs";


    nixpkgs-wayland  = { url = "github:nix-community/nixpkgs-wayland"; };

    # # home-majnager pins nixpkgs to a specific version in its flake.
    # # we want to make sure everything pins to the same version of nixpkgs to be more efficient
    # home-manager = {
    #   url = github:nix-community/home-manager;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # # agenix allows me to store encrypted secrets in the repo just like git-crypt, except
    # # it integrates with nix so I don't need to have world-readable secrets in the nix store.
    # agenix = {
    #   url = "github:ryantm/agenix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # # TODO: separate each config into its own flake to avoid pulling unnecessary deps? or is nix smart enough
    # nixos-wsl = {;
    #   url = "github:nix-community/NixOS-WSL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs: {
      inputs.nixpkgs.overlays = [ import ./overlays/default.nix ]; 
      nixosConfigurations = { 
        miBook = inputs.nixpkgs.lib.nixosSystem { 
          system = "x86_64-linux";
          modules = [
            # Hardware configuration
            ./hosts/miBook/host.nix

            # Device is a personal laptop
         #  ./config/laptop.nix
            ./config/base-desktop.nix
            ./config/personal.nix
            ./config/cli.nix
          
            # Give access to network filestore
         #  ./config/file_access.nix
          
          # # Use X11 Gnome
          # ./config/xorg.nix
          # ./config/oled_gnome.nix

          # Use Wayland Wayfire
            ./module/wayfire.nix

            # Use pipewire
            ./module/audio.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };
  };
}
