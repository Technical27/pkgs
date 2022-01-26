{ wineWowPackages, lib }:

lib.overrideDerivation wineWowPackages.unstable (self: {
  patches = self.patches ++ [ ./childwindow.patch ];
})
