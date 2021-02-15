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
        auto-cpufreq = prev.callPackage ./auto-cpufreq.nix {};
        firefox-with-extensions = import ./firefox.nix {
          inherit (prev) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
        };
        glfw-wayland = prev.callPackage ./glfw.nix {};
        gruvbox-gtk = prev.callPackage ./gruvbox-gtk.nix {};
        gruvbox-icons = prev.callPackage ./gruvbox-icons.nix {};
        info = (import ./info { pkgs = prev; }).package;
        steam = prev.steam.override { extraPkgs = pkgs: with pkgs; [ mesa sqlite ]; };
        polybar = prev.polybar.override { i3GapsSupport = true; };
        wgvpn = mkFish prev "wgvpn";
        startsway = mkFish prev "startsway";
        neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (old: {
          version = "0.5.0-dev";
          src = let
            info = builtins.fromJSON (builtins.readFile ./neovim-src.json);
          in prev.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            inherit (info) rev sha256;
          };
          buildInputs = old.buildInputs ++ [ final.tree-sitter ];
        });
        libusb-patched = prev.libusb1.overrideAttrs (old: {
          src = let
            info = builtins.fromJSON (builtins.readFile ./libusb-src.json);
          in prev.fetchFromGitHub {
            owner = "libusb";
            repo = "libusb";
            inherit (info) rev sha256;
          };
        });
        usbmuxd = prev.usbmuxd.override { libusb1 = final.cpkgs.libusb-patched; };
        vim = import ./vim { inherit (prev) callPackage; };
        lunar-client = prev.lunar-client.overrideAttrs (old: rec {
          version = "2.5.2";
          src = final.fetchurl {
            url = "https://launcherupdates.lunarclientcdn.com/Lunar%20Client-${version}.AppImage";
            name = "lunar-client.AppImage";
            sha256 = "sha256-BUH7SZ3fzS9IJRm9+yK/0LJto9dwsEpNwi1krHKxsyA=";
          };
        });
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
