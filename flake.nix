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
          theme = prev.callPackage ./outputs/gruvbox.nix {};
          icons = prev.callPackage ./outputs/gruvbox.nix { icons = true; };
        };

        tools = {
          pros = import ./outputs/tools/pros { pkgs = final; };
          info = (import ./outputs/tools/info { pkgs = prev; }).package;
          wgvpn = prev.callPackage ./outputs/tools/wgvpn {};
          polybar = prev.polybar.override { i3GapsSupport = true; };
          glfw-wayland = prev.glfw-wayland.overrideAttrs (
            old: {
              patches = old.patches ++ [
                # ./outputs/tools/glfw/0001-set-O_NONBLOCK-on-repeat-timerfd.patch already included
                ./outputs/tools/glfw/0002-Don-t-crash-on-calls-to-focus-or-icon.patch
                ./outputs/tools/glfw/0003-fix-broken-opengl-screenshots-on-mutter.patch
                ./outputs/tools/glfw/0004-Do-not-crash-on-window-position-set.patch
              ];
            }
          );
          tree-sitter = prev.tree-sitter.overrideAttrs (
            old: {
              src = prev.fetchFromGitHub {
                owner = "tree-sitter";
                repo = "tree-sitter";
                rev = "cd96552448a6e0d4eb27fc54b27cb5130c4b6f76";
                sha256 = "sha256-l2XiqyGe5dwvDxM32xSSl8caUyAuNsVfRpAQZ/B5M9U=";
              };
            }
          );
          mangohud = prev.callPackage ./outputs/tools/mangohud {
            libXNVCtrl = final.linuxPackages.nvidia_x11_beta.settings.libXNVCtrl;
            mangohud32 = final.pkgsi686Linux.cpkgs.tools.mangohud;
          };
          cemu = prev.libsForQt5.callPackage ./outputs/tools/cemu.nix {};
          wlroots = prev.callPackage ./outputs/tools/wlroots.nix {};
        };

        games = {
          # TODO: maybe add this again for shapez.io
          # steam = prev.steam.override { extraPkgs = pkgs: with pkgs; [ mesa sqlite ]; };
          guilded = prev.callPackage ./outputs/games/guilded.nix {};
          badlion-client = prev.callPackage ./outputs/games/badlion.nix {};
          roblox = import ./outputs/games/roblox final prev;
          gamescope = prev.callPackage ./outputs/games/gamescope.nix {};
        };
      };
    };

    packages.x86_64-linux = (
      import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlay ];
        config.allowUnfree = true;
      }
    ).cpkgs;

    nixosModule = { ... }: {
      nixpkgs.overlays = [ self.overlay ];
    };
  };
}
