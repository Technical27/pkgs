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
          theme = prev.callPackage ./outputs/gruvbox.nix { };
          icons = prev.callPackage ./outputs/gruvbox.nix { icons = true; };
        };

        pros = import ./outputs/pros { pkgs = final; };
        info = (import ./outputs/info { pkgs = prev; }).package;
        wgvpn = prev.callPackage ./outputs/wgvpn { };
        polybar = prev.polybar.override { i3GapsSupport = true; };
        glfw-wayland = prev.glfw-wayland.overrideAttrs (
          old: {
            patches = old.patches ++ [
              # ./outputs/glfw/0001-set-O_NONBLOCK-on-repeat-timerfd.patch already included
              ./outputs/glfw/0002-Don-t-crash-on-calls-to-focus-or-icon.patch
              ./outputs/glfw/0003-fix-broken-opengl-screenshots-on-mutter.patch
              ./outputs/glfw/0004-Do-not-crash-on-window-position-set.patch
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
        mangohud = prev.callPackage ./outputs/mangohud {
          libXNVCtrl = final.linuxPackages.nvidia_x11_beta.settings.libXNVCtrl;
          mangohud32 = final.pkgsi686Linux.cpkgs.mangohud;
        };
        cemu = prev.libsForQt5.callPackage ./outputs/cemu.nix { };
        wlroots = prev.callPackage ./outputs/wlroots.nix { };
        firebird = prev.libsForQt5.callPackage ./outputs/firebird.nix { };
        joplin = prev.joplin-desktop.overrideAttrs (old: rec {
          version = "2.5.10";
          src = prev.fetchurl {
            url = "https://github.com/laurent22/joplin/releases/download/v${version}/Joplin-${version}.AppImage";
            sha256 = "sha256-636/SifcawS1fdsrSCAASvT147EKn02IXN7DBZRfXME=";
          };
        });
        autovpn = prev.callPackage ./outputs/autovpn { };

        # TODO: maybe add this again for shapez.io
        # steam = prev.steam.override { extraPkgs = pkgs: with pkgs; [ mesa sqlite ]; };
        guilded = prev.callPackage ./outputs/guilded.nix { };
        badlion-client = prev.callPackage ./outputs/badlion.nix { };
        roblox.grapejuice = (
          prev.grapejuice.override {
            wine = final.wineWowPackages.staging;
          }
        );
        gamescope = prev.callPackage ./outputs/gamescope.nix { };
        grapejuice = prev.callPackage ./outputs/roblox { };
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

    hydraJobs.x86_64-linux = self.packages.x86_64-linux;
  };
}
