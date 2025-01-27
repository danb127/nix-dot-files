{
    description = "NixOS configuration with nixvim and hyperpanel overlay";



    inputs = {
    
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
            };

        hyperpanel.url = "github:Jas-SinghFSU/HyprPanel";


        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            };
    };



    outputs = { self, nixpkgs, nixvim, hyperpanel, home-manager, ... }@inputs:
        
        let
        system = "x86_64-linux"; 

        # Import nixpkgs with the hyperpanel overlay
        pkgs = import nixpkgs {
            inherit system;
            # overlays = [ hyperpanel.overlay ];
        };
        in {

            devShells = {
                ${system} = pkgs.mkShell {
                    buildInputs = [
                       pkgs.rustc
                       pkgs.cargo
                       pkgs.pkg-config
                       pkgs.gtk4
                       ];
                };
            };

            
            nixosConfigurations = {
                nixos-danb127 = nixpkgs.lib.nixosSystem {
                    inherit system;
                    modules = [
                        ./nixos/configuration.nix  
                        
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.danb127 = import ./nixos/home.nix;
                            home-manager.extraSpecialArgs = {
                                                            };
                            home-manager.backupFileExtension = "backup";
                        }
                    ];
                };
            };

      perSystem =
        { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };
             
          

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
          };
        };

            # Set default package and app to nvim
            defaultPackage.${system} = self.packages.${system}.nvim;
            defaultApp.${system} = self.packages.${system}.nvim;
        };
}

