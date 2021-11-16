{ wineWowPackages, lib }:

lib.overrideDerivation wineWowPackages.stagingFull (self: {
  patches = self.patches ++ [
    ./patches/childwindow.patch
    ./patches/wayland.patch
  ];
})
