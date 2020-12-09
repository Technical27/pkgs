{
  description = "Custom Packages";

  outputs = { self, nixpkgs }: {
    overlay = final: prev: {
      auto-cpufreq = prev.callPackage ./auto-cpufreq.nix {
        pythonPackages = prev.python3Packages;
      };
      firefox-with-extensions = import ./firefox.nix {
        inherit (prev) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
      };
      context-vim = prev.callPackage ./context-vim.nix {};
      glfw-wayland = prev.callPackage ./glfw.nix {};
      gruvbox-gtk = prev.callPackage ./gruvbox-gtk.nix {};
      gruvbox-icons = prev.callPackage ./gruvbox-icons.nix {};
    };
    nixosModules.auto-cpufreq = { pkgs, ... }: {
      nixpkgs.overlays = [ self.overlay ];
      environment.systemPackages = [ pkgs.auto-cpufreq ];
      systemd.packages = [ pkgs.auto-cpufreq ];
    };
  };
}
