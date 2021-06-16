{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    overlay = final: prev: {
      cpkgs = {
        firefox = import ./outputs/firefox {
          inherit (prev) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
        };

        gruvbox = {
          dark-theme = prev.callPackage ./gruvbox.nix { darkTheme = true; };
          dark-icons = prev.callPackage ./gruvbox.nix { darkTheme = true; icons = true; };
          light-theme = prev.callPackage ./gruvbox.nix {};
          light-icons = prev.callPackage ./gruvbox.nix { icons = true; };
        };

        tools = {
          pros = import ./outputs/tools/pros { pkgs = final; };
          info = (import ./outputs/tools/info { pkgs = prev; }).package;
          mako = prev.mako.overrideAttrs (old: { patches = [ ./outputs/tools/mako.patch ]; });
          theme = prev.callPackage ./outputs/tools/theme {};
          wgvpn = prev.callPackage ./outputs/tools/wgvpn {};
          polybar = prev.polybar.override { i3GapsSupport = true; };
          glfw-wayland = prev.callPackage ./outputs/tools/glfw.nix {};
        };

        vim = import ./outputs/vim { inherit (prev) fetchFromGitHub vimUtils; };

        games = {
          # TODO: maybe add this again for shapez.io
          # steam = prev.steam.override { extraPkgs = pkgs: with pkgs; [ mesa sqlite ]; };
          guilded = prev.callPackage ./outputs/games/guilded.nix {};
          badlion-client = prev.callPackage ./outputs/games/badlion.nix {};
          roblox = import ./outputs/games/roblox final prev;
        };
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
