{ appimageTools, lib, fetchurl, makeDesktopItem }:

let
  name = "badlion-client";
  version = "3.6.2";

  desktopItems = [
    (makeDesktopItem
      {
        name = "badlion-client";
        exec = "badlion-client";
        icon = "badlionclient";
        comment = "Minecraft Client";
        desktopName = "Badlion Client";
        genericName = "Minecraft Client";
        categories = "Game;";
      })
  ];

  appimageContents = appimageTools.extract {
    inherit name src;
  };

  src = fetchurl {
    name = "BadlionClient";
    url = "https://client-updates-cdn77.badlion.net/BadlionClient";
    sha256 = "sha256-7QKWHjlC3tpAPWOtYCBdQDhPtBKqBO99taxfcoVz7Cw=";
  };
in
appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp -r ${appimageContents}/usr/share/icons/ $out/share/
  '';

  extraPkgs = pkgs: [ pkgs.libpulseaudio ];

  meta = with lib; {
    description = "Minecraft Client";
    homepage = "https://client.badlion.net/";
    license = with licenses; [ unfree ];
    maintainers = with maintainers; [ Technical27 ];
    platforms = [ "x86_64-linux" ];
  };
}
