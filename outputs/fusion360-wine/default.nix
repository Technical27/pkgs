{ wineWowPackages, lib }:

lib.overrideDerivation wineWowPackages.staging (self: {
  patches = self.patches ++ [ ./childwindow.patch ];
})
