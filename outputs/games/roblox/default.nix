final: prev:

rec {
  wine = final.wineWowPackages.staging;
  grapejuice = prev.grapejuice.override {
    inherit wine;
  };
  rbxfpsunlocker = prev.callPackage ./rbxfpsunlocker.nix {
    inherit wine;
  };
}
