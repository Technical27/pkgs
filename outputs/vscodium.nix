{ vscodium, makeDesktopItem }:
vscodium.overrideAttrs (
  old: rec {
    preFixup = old.preFixup ++ ''
      gappsWrapperArgs+=(
        --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      )
    '';
  }
)
