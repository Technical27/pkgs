{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    overlays = {
      main = final: prev: {
        cpkgs = {
          gruvbox = {
            theme = prev.callPackage ./outputs/gruvbox.nix { };
            icons = prev.callPackage ./outputs/gruvbox.nix { icons = true; };
          };

          pros = prev.callPackage ./outputs/pros { };
          info = (import ./outputs/info { pkgs = prev; }).package;
          wgvpn = prev.callPackage ./outputs/wgvpn { };
          polybar = prev.polybar.override { i3Support = true; };
          glfw-wayland = prev.glfw-wayland.overrideAttrs (
            old: {
              patches = [
                ./outputs/glfw/0002-Don-t-crash-on-calls-to-focus-or-icon.patch
                ./outputs/glfw/0003-fix-broken-opengl-screenshots-on-mutter.patch
                ./outputs/glfw/0004-Do-not-crash-on-window-position-set.patch
                # NOTE: This is now a file instead of a list...
                old.patches
              ];
            }
          );
          cemu = prev.libsForQt5.callPackage ./outputs/cemu.nix { };
          firebird = prev.libsForQt5.callPackage ./outputs/firebird.nix { };
          joplin = prev.joplin-desktop.overrideAttrs (old: rec {
            version = "2.5.10";
            src = prev.fetchurl {
              url = "https://github.com/laurent22/joplin/releases/download/v${version}/Joplin-${version}.AppImage";
              sha256 = "sha256-636/SifcawS1fdsrSCAASvT147EKn02IXN7DBZRfXME=";
            };
          });
          autovpn = prev.callPackage ./outputs/autovpn.nix { };

          guilded = prev.callPackage ./outputs/guilded.nix { };
          badlion-client = prev.callPackage ./outputs/badlion.nix { };
          grapejuice = prev.callPackage ./outputs/roblox { };
          gamescope = prev.callPackage ./outputs/gamescope { };

          vscodium = prev.callPackage ./outputs/vscodium.nix { };

          robotmeshnative = prev.callPackage ./outputs/robotmeshnative.nix { };

          soundux = prev.callPackage ./outputs/soundux.nix { };

          neo = prev.callPackage ./outputs/neo.nix { };

          ancs4linux = prev.callPackage ./outputs/ancs4linux { };
          fusion360-wine = prev.callPackage ./outputs/fusion360-wine { };

          olive = prev.libsForQt5.callPackage ./outputs/olive.nix {
            inherit (prev.darwin.apple_sdk) CoreFoundation;
            opencolorio = prev.callPackage ./outputs/opencolorio.nix {
              inherit (prev.darwin.apple_sdk) Carbon GLUT Cocoa;
            };
          };

          pcem = prev.callPackage ./outputs/pcem.nix { };

          n-link = prev.callPackage ./outputs/n-link.nix { };

          mangohud = prev.callPackage ./outputs/mangohud {
            libXNVCtrl = prev.linuxPackages.nvidia_x11.settings.libXNVCtrl;
            mangohud32 = prev.pkgsi686Linux.mangohud;
          };

          systemd-networkd-vpnc = prev.callPackage ./outputs/systemd-networkd-vpnc.nix { };

          wlroots = prev.wlroots_0_16.overrideAttrs (old: rec {
            src = prev.fetchFromGitHub {
              owner = "Technical27";
              repo = "wlroots";
              rev = "d57191b8cd2304ff77ca4226841483ea4a74c431";
              sha256 = "sha256-0gZRMBf3L4OBlYLbD64HSl8n9x4wkmkA6dqYV715yNk=";
            };
          });

          sway-unwrapped = prev.sway-unwrapped.override { wlroots_0_16 = final.cpkgs.wlroots; };
          sway = prev.sway.override { sway-unwrapped = final.cpkgs.sway-unwrapped; };

          rtl88xxau = prev.callPackage ./outputs/rtl88xxau.nix { kernel = final.linuxKernel.packageAliases.linux_latest.kernel; };
        };
      };
    };

    packages.x86_64-linux = (
      import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlays.main ];
        config.allowUnfree = true;
      }
    ).cpkgs;

    nixosModule = { ... }: {
      nixpkgs.overlays = [ self.overlays.main ];
    };

    hydraJobs.x86_64-linux = self.packages.x86_64-linux;
  };
}
