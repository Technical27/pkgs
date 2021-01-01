{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    supportedSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
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

      systemd.services.auto-cpufreq = {
        description = "auto-cpufreq - Automatic CPU speed & power optimizer for Linux";
        after = [ "network.target" "network-online.target" ];
        unitConfig.ConditionPathExists = "/var/log/auto-cpufreq.log";
        path = [ ncurses bash ];
        serviceConfig = {
          Type = "simple";
          User = "root";
          ExecStart = "${cpkgs.auto-cpufreq}/bin/auto-cpufreq --daemon";
          StandardOutput = "append:/var/log/auto-cpufreq.log";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
