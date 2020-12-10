{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    legacyPackages.x86_64-linux = {
      auto-cpufreq = nixpkgs.callPackage ./auto-cpufreq.nix {
        pythonPackages = nixpkgs.python3Packages;
      };
      firefox-with-extensions = import ./firefox.nix {
        inherit (nixpkgs) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
      };
      context-vim = nixpkgs.callPackage ./context-vim.nix {};
      glfw-wayland = nixpkgs.callPackage ./glfw.nix {};
      gruvbox-gtk = nixpkgs.callPackage ./gruvbox-gtk.nix {};
      gruvbox-icons = nixpkgs.callPackage ./gruvbox-icons.nix {};
    };
    nixosModules.auto-cpufreq = { pkgs, ... }: {
      inherit (self.legacyPackages.x86_64-linux) auto-cpufreq;
      environment.systemPackages = [ auto-cpufreq ];

      systemd.services.auto-cpufreq = {
        description = "auto-cpufreq - Automatic CPU speed & power optimizer for Linux";
        after = [ "network.target" "network-online.target" ];
        unitConfig.ConditionPathExists = "/var/log/auto-cpufreq.log";
        serviceConfig = {
          Type = "simple";
          User = "root";
          ExecStart = "${auto-cpufreq}/bin/auto-cpufreq --daemon";
          StandardOutput = "append:/var/log/auto-cpufreq.log";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
