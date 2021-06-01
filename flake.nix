{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    mkFish = prev: name: prev.writeTextFile {
        inherit name;
        destination = "/bin/${name}";
        executable = true;
        text = "#! ${prev.fish}/bin/fish\n" +
          builtins.readFile (./. + "/${name}.fish");
      };
  in {
    overlay = final: prev: {
      cpkgs = {
        firefox-with-extensions = import ./firefox.nix {
          inherit (prev) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
        };
        glfw-wayland = prev.callPackage ./glfw.nix {};
        gruvbox-dark-theme = prev.callPackage ./gruvbox.nix { darkTheme = true; };
        gruvbox-dark-icons = prev.callPackage ./gruvbox.nix { darkTheme = true; icons = true; };
        gruvbox-light-theme = prev.callPackage ./gruvbox.nix {};
        gruvbox-light-icons = prev.callPackage ./gruvbox.nix { icons = true; };
        info = (import ./info { pkgs = prev; }).package;
        # steam = prev.steam.override { extraPkgs = pkgs: with pkgs; [ mesa sqlite ]; };
        polybar = prev.polybar.override { i3GapsSupport = true; };
        wgvpn = mkFish prev "wgvpn";
        startsway = mkFish prev "startsway";
        context-vim = prev.callPackage ./context-vim.nix {};
        theme = prev.callPackage ./theme {};
        waybar = prev.waybar.overrideAttrs (old: rec {
          version = "0.9.7";
          src = final.fetchFromGitHub {
            owner = "Alexays";
            repo = "Waybar";
            rev = version;
            sha256 = "17cn4d3dx92v40jd9vl41smp8hh3gf5chd1j2f7l1lrpfpnllg5x";
          };
          patches = [];
        });
        mangohud = prev.callPackage ./mangohud.nix {
          inherit (final.linuxPackages_latest) nvidia_x11;
        };
        mangohud_32 = prev.pkgsi686Linux.callPackage ./mangohud.nix {
          inherit (final.linuxPackages_latest) nvidia_x11;
        };
        mako = prev.mako.overrideAttrs (old: { patches = [ ./mako.patch ]; });
        guilded = prev.callPackage ./guilded.nix {};
        lunar-client = prev.callPackage ./lunar.nix {};
      };
    };

    packages.x86_64-linux = (import nixpkgs {
      system = "x86_64-linux";
      overlays = [ self.overlay ];
      config.allowUnfree = true;
    }).cpkgs;

    nixosModule = { ... }: {
      nixpkgs.overlays = [ self.overlay ];
    };
  };
}
