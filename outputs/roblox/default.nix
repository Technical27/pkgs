{ grapejuice, wineWowPackages, lib }:

let
  roblox-wine = lib.overrideDerivation wineWowPackages.staging (self: {
    patches = self.patches ++ [ ./mouse-fix.patch ];
  });
in
grapejuice.override { wine = roblox-wine; }
