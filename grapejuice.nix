{ lib, python3Packages, fetchFromGitLab, pygobject-stubs, wine, xdg-user-dirs, wrapGAppsHook, gobject-introspection, gtk3, xdg_utils, shared-mime-info, desktop-file-utils, makeDesktopItem }:


let
  grapejuiceItem = makeDesktopItem {
    desktopName = "Grapejuice";
    name = "grapejuice";
    exec = "grapejuice gui";
    icon = "grapejuice";
    comment = "manage roblox";
    categories = "Development;";
  };
  robloxPlayerItem = makeDesktopItem {
    desktopName = "Roblox";
    name = "roblox-player";
    exec = "grapejuice player %u";
    icon = "grapejuice-roblox-player";
    mimeType = "x-scheme-handler/roblox-player";
    categories = "Game;";
    noDisplay = true;
    extraEntries = ''
      OnlyShowIn=X-None;
      StartupWMClass=RobloxPlayer.exe
    '';
  };
  robloxStudioItem = makeDesktopItem {
    desktopName = "Roblox Studio";
    name = "roblox-studio";
    exec = "grapejuice studio %u";
    icon = "grapejuice-roblox-studio";
    mimeType = "x-scheme-handler/roblox-studio";
    categories = "Game;";
    extraEntries = ''
      StartupWMClass=RobloxStudio.exe
    '';
  };
in python3Packages.buildPythonPackage rec {
  pname = "grapejuice";
  version = "3.9.2";

  src = fetchFromGitLab {
    owner = "BrinkerVII";
    repo = pname;
    rev = "ccf269205ca958b57701814a64b2ac1b3d41dd94";
    sha256 = "sha256-G9PfQyoqgiU7tbpG1MxfUp64F/5a2Td7DY7t4QKmUNk=";
  };

  postInstall = ''
    wrapProgram $out/bin/grapejuice \
      --prefix PATH ":" ${lib.makeBinPath [ wine xdg-user-dirs xdg_utils desktop-file-utils ]}

    mkdir -p $out/share/applications
    cp ${grapejuiceItem}/share/applications/* $out/share/applications
    cp ${robloxPlayerItem}/share/applications/* $out/share/applications
    cp ${robloxStudioItem}/share/applications/* $out/share/applications
  '';

  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs = [ gtk3 gobject-introspection shared-mime-info ];

  propagatedBuildInputs = with python3Packages; [ psutil pygobject-stubs pygobject3 packaging wheel requests dbus-python setuptools ];
}
