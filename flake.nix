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
        context-vim = prev.callPackage ./context-vim.nix {};
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

    nixosModules.auto-cpufreq = { pkgs, ... }: with pkgs; {
      environment.systemPackages = [ cpkgs.auto-cpufreq ];

      systemd.packages = [ cpkgs.auto-cpufreq ];

      systemd.services.auto-cpufreq.path = with pkgs; [ bash coreutils ];
    };
  };
}
