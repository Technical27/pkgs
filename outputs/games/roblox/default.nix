final: prev:

{
  grapejuice = prev.grapejuice.override {
    wine = final.wineWowPackages.staging;
  };
  rbxfpsunlocker = prev.callPackage ./rbxfpsunlocker.nix {
    wine = final.wineWowPackages.staging;
  };
}
