final: prev:

{
  wine = prev.lib.overrideDerivation prev.wineWowPackages.staging (old: {
    patches = old.patches ++ [ ./wine-roblox.patch ];
  });
  grapejuice = prev.callPackage ./grapejuice.nix {
    pygobject-stubs = prev.python3Packages.callPackage ./pygobject-stubs.nix {};
    wine = final.cpkgs.games.roblox.wine;
  };
  rbxfpsunlocker = prev.callPackage ./rbxfpsunlocker.nix {
    wine = final.cpkgs.games.roblox.wine;
  };
}
