{ appimageTools, lib, fetchurl, makeDesktopItem }:

let
  name = "badlion-client";
  version = "3.1.10";

  desktopItem = makeDesktopItem {
    name = "Badlion Client";
    exec = "badlion-client";
    icon = "badlionclient";
    comment = "Minecraft 1.7, 1.8, 1.12, 1.15, and 1.16 Client";
    desktopName = "Badlion Client";
    genericName = "Minecraft Client";
    categories = "Game;";
  };

  appimageContents = appimageTools.extract {
    inherit name src;
  };

  src = fetchurl {
    name = "BadlionClient";
    url = "https://client-updates-cdn77.badlion.net/BadlionClient";
    sha256 = "sha256-uhluveIjyLr7oJe5tAREpxdRjtMkky9fUAgU5ZP/qtw=";
  };
in
appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications
    cp -r ${appimageContents}/usr/share/icons/ $out/share/
  '';

  extraPkgs = pkgs: [ pkgs.libpulseaudio ];

  meta = with lib; {
    description = "Minecraft 1.7, 1.8, 1.12, 1.15, and 1.16 Client";
    homepage = "https://client.badlion.net/";
    license = with licenses; [ unfree ];
    maintainers = with maintainers; [ Technical27 ];
    platforms = [ "x86_64-linux" ];
  };
}
