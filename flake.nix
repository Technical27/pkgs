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
          polybar = prev.polybar.override { i3GapsSupport = true; };
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

          biber = prev.callPackage ./outputs/biber.nix { };
        };
      };

      nvidia = final: prev: {
        wlroots = prev.wlroots.overrideAttrs (old: {
          postPatch = ''
            sed -i 's/assert(argb8888 &&/assert(true || argb8888 ||/g' 'render/wlr_renderer.c'
          '';
        });
        egl-wayland = prev.egl-wayland.overrideAttrs (old: rec {
          version = "1.1.9.99";
          src = prev.fetchFromGitHub {
            owner = "NVIDIA";
            repo = "egl-wayland";
            rev = "daab8546eca8428543a4d958a2c53fc747f70672"; # Oct 29 2021
            sha256 = "sha256-IrLeqBW74mzo2OOd5GzUPDcqaxrsoJABwYyuKTGtPsw=";
          };
          buildInputs = old.buildInputs ++ [ prev.wayland-protocols ];
        });
        libglvnd = prev.libglvnd.overrideAttrs (old: rec {
          version = "1.3.4.99";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "glvnd";
            repo = "libglvnd";
            rev = "2d69d4720c56d2d8ab1f81eff62eecd069f14c62"; # Oct 28 2021
            sha256 = "sha256-137gLX7LgfOBNnci9rnp4fg194m3ieY2q9HuRhQdb1Y=";
          };
        });
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
