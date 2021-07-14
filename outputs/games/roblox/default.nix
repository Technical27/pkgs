final: prev:

rec {
  wine = prev.lib.overrideDerivation prev.wineWowPackages.staging (
    old: {
      # roblox will freeze the cursor on any camera change
      # this is a patch to prevent that
      patches = old.patches ++ [ ./mouse_fix.patch ];
    }
  );
  grapejuice = prev.grapejuice.override {
    inherit wine;
  };
  rbxfpsunlocker = prev.callPackage ./rbxfpsunlocker.nix {
    inherit wine;
  };
}
