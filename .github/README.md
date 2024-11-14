## Build raylib from source
Download the raylib repository from [Github](https://github.com/raysan5/raylib):
```bash
git clone --depth 1 https://github.com/raysan5/raylib.git raylib
cd raylib/src/
```

Create a `shell.nix` with the following:
```nix
{ pkgs ? import <nixpkgs> {} }:

  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      xorg.libX11.dev
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXi
    ];
}
```

Enter the shell wth:
```nix
nix-shell
```

Then compile it with:
```bash
make PLATFORM=PLATFORM_DESKTOP
```

Edit the `raylib/src/Makefile` and change the `DESTDIR` variable to your local path. I like to put in `$HOME/.local`:
```makefile
DESTDIR ?= $(HOME)/.local
RAYLIB_INSTALL_PATH ?= $(DESTDIR)/lib
RAYLIB_H_INSTALL_PATH ?= $(DESTDIR)/include
```

Install the library to the directories above:
```bash
sudo make install
```
