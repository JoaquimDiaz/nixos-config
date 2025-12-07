{
  description = "Suckless NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      makeSystem = { hostName, timeZone, system }:
        nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit self; };
          modules = [
	    # Global modules configuration for the specified host
            "${./hosts}/${hostName}/configuration.nix"
	    
	    # User config with home-manager
            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostName;
              time.timeZone = timeZone;

              users.users.jo = {
                isNormalUser = true;
                extraGroups = [
                  "wheel"
                  "networkmanager"
                  "audio"
                  "video"
                  "input"
                  "bluetooth"
                  "plugdev"
                  "docker"
                ];
              };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = { inherit self hostName; };
              home-manager.users.jo = import ./home/home.nix;

              home-manager.backupFileExtension = "backup";
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixos-rog = makeSystem {
          hostName = "nixos-rog";
	  system = "x86_64-linux";
          timeZone = "Europe/Paris";
        };
      };
    };
}
