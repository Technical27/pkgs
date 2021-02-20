{ appimageTools, lib, fetchurl, makeDesktopItem }:
let
  name = "lunar-client";
  version = "2.5.2";

  desktopItem = makeDesktopItem {
    name = "Lunar Client";
    exec = "lunar-client";
    icon = "lunarclient";
    comment = "Optimized Minecraft Client for 1.7.10 and 1.8.9";
    desktopName = "Lunar Client";
    genericName = "Minecraft Client";
    categories = "Game;";
  };

  appimageContents = appimageTools.extract {
    inherit name src;
  };

  src = fetchurl {
    url = "https://launcherupdates.lunarclientcdn.com/Lunar%20Client-${version}.AppImage";
    name = "lunar-client.AppImage";
    sha256 = "sha256-BUH7SZ3fzS9IJRm9+yK/0LJto9dwsEpNwi1krHKxsyA=";
  };
in appimageTools.wrapType1 rec {
  inherit name src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications
    cp -r ${appimageContents}/usr/share/icons/ $out/share/
  '';

  meta = with lib; {
    description = "Minecraft 1.7.10 & 1.8.9 PVP Client";
    homepage = "https://www.lunarclient.com/";
    license = with licenses; [ unfree ];
    maintainers = with maintainers; [ Technical27 ];
    platforms = [ "x86_64-linux" ];
  };

  extraPkgs = pkgs: with pkgs; [
    libpulseaudio
  ];
}
