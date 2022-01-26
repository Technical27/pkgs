{ wineWowPackages, lib }:

lib.overrideDerivation wineWowPackages.stagingFull (self: {
  patches = self.patches ++ [ ./childwindow.patch ];
})
