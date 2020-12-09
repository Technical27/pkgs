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

      systemd.services.auto-cpufreq = {
        description = "auto-cpufreq - Automatic CPU speed & power optimizer for Linux";
        after = [ "network.target" "network-online.target" ];
        unitConfig.ConditionPathExists = "/var/log/auto-cpufreq.log";
        serviceConfig = {
          Type = "simple";
          User = "root";
          ExecStart = "${pkgs.auto-cpufreq}/bin/auto-cpufreq --daemon";
          StandardOutput = "append:/var/log/auto-cpufreq.log";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
