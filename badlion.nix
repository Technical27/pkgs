{ appimageTools, lib, requireFile, makeDesktopItem }:

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

  src = requireFile rec {
    name = "BadlionClient";
    url = "https://client.badlion.net/";
    sha256 = "1y6l46709s7pi4jl4503bzwjnyn1jgbyqh8ajk8m4rc6h7jkif6c";
    message = ''
      This Nix expression requires Badlion Client to be downloaded manually.
      In order to build it, you need to:
        - go to ${url}
        - download under "Linux Download"
        - do nix-store --add-fixed sha256 ${name}
    '';
  };
in appimageTools.wrapType2 rec {
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
