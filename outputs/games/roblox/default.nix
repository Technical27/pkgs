final: prev:

rec {
  wine = prev.lib.overrideDerivation prev.wineWowPackages.staging (
    old: {
      # roblox will freeze the cursor on any camera change
      # this is a patch to prevent that
      patches = old.patches ++ [ ./mouse_fix.patch ];
    }
  );
  grapejuice = (
    prev.grapejuice.override {
      inherit wine;
    }
  ).overrideAttrs (
    old: {
      src = prev.fetchFromGitLab {
        owner = "brinkervii";
        repo = "grapejuice";
        rev = "61f9cb33b00659c0bac5c7dc73275eb1deeb987a";
        sha256 = "sha256-LbM4HF6M4eRtJJstsz7QnUWF+V/lW8nSYLP0F2Kds64=";
      };
    }
  );
  rbxfpsunlocker = prev.callPackage ./rbxfpsunlocker.nix {
    inherit wine;
  };
}
