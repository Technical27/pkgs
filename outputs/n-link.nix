{ appimageTools, lib, fetchurl, makeDesktopItem }:

let
  name = "n-link";
  version = "0.1.6";
  src = fetchurl {
    name = "n-link";
    url = "https://github.com/lights0123/n-link/releases/download/v${version}/desktop_${version}_amd64.AppImage";
    sha256 = "sha256-r7dVxoiDw8nns0WPw3LUiCtID2ZDgiAGF1eYIq7iKnA=";
  };

  desktopItem = makeDesktopItem {
    name = "N-LINK";
    exec = "n-link";
    icon = "n-link";
    desktopName = "N-LINK";
  };

  appimageContents = appimageTools.extract {
    inherit name src;
  };
in
appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications
    cp -r ${appimageContents}/usr/share/icons/ $out/share/
  '';

  extraPkgs = pkgs: [ pkgs.webkitgtk ];
}

