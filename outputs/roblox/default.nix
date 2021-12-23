{ grapejuice, wineWowPackages, lib }:

grapejuice.override {
  wine = lib.overrideDerivation wineWowPackages.staging (self: {
    patches = self.patches ++ [ ./mouse-fix.patch ];
  });
}
