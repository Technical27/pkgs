{
  description = "Custom Packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    overlays = {
      main = final: prev: {
        cpkgs = {
          wgvpn = prev.callPackage ./outputs/wgvpn { };
          polybar = prev.polybar.override { i3Support = true; };
          autovpn = prev.callPackage ./outputs/autovpn.nix { };

          guilded = prev.callPackage ./outputs/guilded.nix { };
          badlion-client = prev.callPackage ./outputs/badlion.nix { };

          soundux = prev.callPackage ./outputs/soundux.nix { };

          fusion360-wine = prev.callPackage ./outputs/fusion360-wine { };

          pcem = prev.callPackage ./outputs/pcem.nix { };

          n-link = prev.callPackage ./outputs/n-link.nix { };

          systemd-networkd-vpnc = prev.callPackage ./outputs/systemd-networkd-vpnc.nix { };
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
