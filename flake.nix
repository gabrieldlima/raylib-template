{
  description = "Raylib development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = [
        pkgs.libGL

        # X11 dependencies
        pkgs.xorg.libX11
        pkgs.xorg.libX11.dev
        pkgs.xorg.libXcursor
        pkgs.xorg.libXi
        pkgs.xorg.libXinerama
        pkgs.xorg.libXrandr

        # Uncomment the line below if you want to build Raylib with web support
        # pkgs.emscripten
      ];
    };
  };
}
