{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs =
    inputs @ { self
    , nixpkgs
    , darwin
    , home-manager
    , flake-utils
    , ...
    }:
    let
      systems = [ "x86_64-darwin" "aarch64-darwin" "aarch64-linux" "x86_64-linux" ];
      username = "anhoder";
      hostname = "anhoder";

      specialArgs =
        inputs
        // {
          inherit hostname username;
        };

      formatters = flake-utils.lib.eachSystem systems (system: {
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });

      allPackages = flake-utils.lib.eachSystem systems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          # darwin
          packages.darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
            inherit pkgs system specialArgs;
            modules = [
              ./modules/nix-core.nix
              ./modules/darwin-system.nix
              ./modules/darwin-apps.nix
              ./modules/darwin-host-users.nix

              #home manager
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = import ./home;
                home-manager.extraSpecialArgs = {
                  inherit pkgs username hostname;
                  homeDirectory = "/Users/${username}";
                };
              }
            ];
          };
          # not darwin
          packages.homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./modules/nix-core.nix
              ./home/default.nix
            ];

            extraSpecialArgs = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          };
        });
    in
    {
      # nix code formatter
      inherit (formatters) formatter;
      inherit (allPackages) packages;
    };
}
