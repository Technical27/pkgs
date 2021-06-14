{ stdenv, bash, wine, unzip, fetchurl, makeDesktopItem }:

let
  desktopItem = makeDesktopItem {
    name = "rbxfpsunlocker";
    desktopName = "rbxfpsunlocker";
    exec = "rbxfpsunlocker";
    comment = "Roblox FPS Unlocker";
    categories = "Game;";
  };
in stdenv.mkDerivation rec {
  pname = "rbxfpsunlocker";
  version = "0.0.0";
  preferLocalBuild = true;

  src = fetchurl {
    url = "https://github.com/axstin/rbxfpsunlocker/files/5203772/rbxfpsunlocker-x64.zip";
    sha256 = "sha256-XCxNhFSMO+mGo7MCAgTLXBDCOugnO94iWGqJEJwFUEw=";
  };

  dontConfigure = true;

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    unzip ${src} -d pkg
    sourceRoot=pkg
  '';

  buildPhase = ''
    cat > rbxfpsunlocker << EOF
    #!${bash}/bin/sh
    mkdir -p ~/.config/rbxfpsunlocker
    cd ~/.config/rbxfpsunlocker
    export WINEPREFIX=~/.local/share/grapejuice/wineprefix
    exec nohup ${wine}/bin/wine64 $out/share/rbxfpsunlocker/rbxfpsunlocker.exe &>/dev/null &
  '';

  installPhase = ''
    install -Dm444 rbxfpsunlocker.exe $out/share/rbxfpsunlocker/rbxfpsunlocker.exe
    install -Dm555 -t $out/bin rbxfpsunlocker
  '';
}
