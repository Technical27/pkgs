{ fetchurl, dpkg
, autoPatchelfHook, makeDesktopItem, lib, stdenv, wrapGAppsHook
, alsaLib, at-spi2-atk, at-spi2-core, atk, cairo, cups, dbus, expat, fontconfig
, freetype, gdk-pixbuf, glib, gtk3, libcxx, libdrm, libnotify, libpulseaudio, libuuid
, libX11, libXScrnSaver, libXcomposite, libXcursor, libXdamage, libXext
, libXfixes, libXi, libXrandr, libXrender, libXtst, libxcb
, mesa, nspr, nss, pango, systemd, libappindicator-gtk3, libdbusmenu
}:

stdenv.mkDerivation rec {
  pname = "guilded";
  version = "unstable-2021-05-18";
  src = fetchurl {
    url = "https://www.guilded.gg/downloads/Guilded-Linux.deb";
    sha256 = "14d1bb2cf0cng8md2c4x63wjj34fjrb5jjq8l0774iylz7yzgs0g";
  };

  nativeBuildInputs = [
    alsaLib
    autoPatchelfHook
    cups
    libdrm
    libuuid
    libXdamage
    libX11
    libXScrnSaver
    libXtst
    libxcb
    mesa.drivers
    nss
    wrapGAppsHook
    dpkg
  ];

  unpackPhase = ''
    mkdir pkg
    dpkg-deb -x $src pkg
    sourceRoot=pkg
  '';

  dontWrapGApps = true;

  libPath = lib.makeLibraryPath [
    libcxx systemd libpulseaudio
    stdenv.cc.cc alsaLib atk at-spi2-atk at-spi2-core cairo cups dbus expat fontconfig freetype
    gdk-pixbuf glib gtk3 libnotify libX11 libXcomposite libuuid
    libXcursor libXdamage libXext libXfixes libXi libXrandr libXrender
    libXtst nspr nss libxcb pango systemd libXScrnSaver
    libappindicator-gtk3 libdbusmenu
  ];

  # for some reason it can't find libxkbcommon-x11.so.0 even though it can find libxkbcommon.so.0
  autoPatchelfIgnoreMissingDeps=true;

  installPhase = ''
    mkdir -p $out/{opt,bin}
    mv opt/Guilded $out/opt
    mv usr/share $out
    chmod +x $out/opt/Guilded/guilded
    patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
        $out/opt/Guilded/guilded
    wrapProgram $out/opt/Guilded/guilded \
        "''${gappsWrapperArgs[@]}" \
        --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
        --prefix LD_LIBRARY_PATH : ${libPath}
    ln -s $out/opt/Guilded/guilded $out/bin/
    substituteInPlace $out/share/applications/guilded.desktop --replace "/opt/Guilded/guilded" guilded
  '';
    # ln -s "${desktopItem}/share/applications" $out/share/

  # desktopItem = makeDesktopItem {
  #   name = pname;
  #   exec = "guilded";
  #   icon = pname;
  #   desktopName = "Guilded";
  #   genericName = meta.description;
  #   categories = "Network;InstantMessaging;";
  #   # mimeType = "x-scheme-handler/discord";
  # };

  # passthru.updateScript = ./update-discord.sh;

  meta = with lib; {
    description = "Chat for gaming communites";
    homepage = "https://www.guilded.gg/";
    downloadPage = "https://www.guilded.gg/downloads";
    license = licenses.unfree;
    maintainers = with maintainers; [ Technical27 ];
    platforms = [ "x86_64-linux" ];
  };
}
