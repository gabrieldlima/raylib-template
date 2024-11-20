# Nix/NixOS raylib setup

1. Begin by downloading the latest stable release of raylib into your project folder. Use the following commands:
```sh
cd your-project-folder
mkdir external
wget https://github.com/raysan5/raylib/archive/refs/tags/5.5.tar.gz -P external/
tar xvf external/5.5.tar.gz -C external/
```

2. Create a `flake.nix` file in the root folder of your project with the following content:
```nix
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
```

3. Create the development environment with the dependencies using:
```sh
nix develop
```

</details>
<details><summary> Or with nix channels </summary>

Alternatively, you can create a `shell.nix` file in the root folder of your project with the following content:
```nix
{ pkgs ? import <nixpkgs> {} }:

  pkgs.mkShell {
    nativeBuildInputs = [
      pkgs.libGL

      # X11 dependencies
      pkgs.xorg.libX11
      pkgs.xorg.libX11.dev
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.xorg.libXinerama
      pkgs.xorg.libXrandr

      # Web support (uncomment to enable)
      # pkgs.emscripten
    ];
}
```

Then, run the following command to enter the nix-shell:
```sh
nix-shell
```
</details>

4. To build raylib, navigate to the src directory inside the external/raylib-5.5 folder and run make:
```sh
cd external/raylib-5.5/src/
make PLATFORM=PLATFORM_DESKTOP
```

5. Now you can compile your project with Raylib. The simplest possible Makefile for this would be:
```makefile
RAYLIB ?= ./external/raylib-5.5/src/

all:
	gcc src/main.c -I $(RAYLIB) -L $(RAYLIB) -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
```
