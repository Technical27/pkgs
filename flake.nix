{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    supportedSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    mkFish = name: prev.writeTextFile {
        inherit name;
        destination = "/bin/${name}";
        executable = true;
        text = "#! ${final.fish}/bin/fish\n" +
          builtins.readFile ./. + "${name}.fish";
      };
  in {
    overlay = final: prev: {
      cpkgs = {
        auto-cpufreq = prev.callPackage ./auto-cpufreq.nix {};
        firefox-with-extensions = import ./firefox.nix {
          inherit (prev) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
        };
        context-vim = prev.callPackage ./context-vim.nix {};
        glfw-wayland = prev.callPackage ./glfw.nix {};
        gruvbox-gtk = prev.callPackage ./gruvbox-gtk.nix {};
        gruvbox-icons = prev.callPackage ./gruvbox-icons.nix {};
        liquidctl = prev.callPackage ./liquidctl.nix {};
        mcbedrock = prev.callPackage ./mcbedrock.nix {};
        steam = prev.steam.override { extraPkgs = pkgs: with pkgs; [ mesa sqlite ]; };
        polybar = prev.polybar.override { i3GapsSupport = true; };
        wgvpn = mkFish "wgvpn";
        startsway = mkFish "startsway";
        ibus-launch = mkFish "ibus-launch";
        pipewire = prev.pipewire.overrideAttrs (old: rec {
          version = "0.3.19";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "pipewire";
            repo = "pipewire";
            rev = "0.3.19";
            sha256 = "sha256-9zMDdy3Uqr4Ada5uMRuqTpzr5BjSDY5UjTo4g2InezE=";
          };
        });
      };
    };

    packages = forAllSystems (system: (import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    }).cpkgs);

    nixosModule = { ... }: {
      nixpkgs.overlays = [ self.overlay ];
    };

    nixosModules.auto-cpufreq = { pkgs, ... }: with pkgs; {
      environment.systemPackages = [ cpkgs.auto-cpufreq ];

      systemd.packages = [ cpkgs.auto-cpufreq ];

      systemd.services.auto-cpufreq.path = with pkgs; [ bash coreutils ];
    };
  };
}
