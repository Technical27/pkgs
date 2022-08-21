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

          systemd-networkd-vpnc = prev.callPackage ./outputs/systemd-networkd-vpnc.nix { };

          zathuraPkgs = rec {
            inherit
              (prev.zathuraPkgs)
              gtk
              zathura_djvu
              zathura_pdf_poppler
              zathura_ps
              zathura_core
              zathura_cb
              ;

            zathura_pdf_mupdf = prev.zathuraPkgs.zathura_pdf_mupdf.overrideAttrs (o: {
              patches = [ ./outputs/zathura.patch ];
            });

            zathuraWrapper = prev.zathuraPkgs.zathuraWrapper.overrideAttrs (o: {
              paths = [
                zathura_core.man
                zathura_core.dev
                zathura_core.out
                zathura_djvu
                zathura_ps
                zathura_cb
                zathura_pdf_mupdf
              ];
            });
          };

          zathura = final.cpkgs.zathuraPkgs.zathuraWrapper;
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
