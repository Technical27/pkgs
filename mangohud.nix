{ stdenv
, lib
, fetchFromGitHub
, fetchpatch
, meson
, ninja
, pkg-config
, python3Packages
, dbus
, glslang
, libglvnd
, mesa
, vulkan-headers
, vulkan-loader
, xorg
, nvidia_x11
}:

let
  libdir = "lib${lib.optionalString stdenv.is32bit "32"}";
in stdenv.mkDerivation rec {
  pname = "mangohud${lib.optionalString stdenv.is32bit "_32"}";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "flightlessmango";
    repo = "MangoHud";
    rev = "v${version}";
    sha256 = "sha256-xoL+eqbCM0cXoGGNeFq3nDE/n45OH6x+mTP1jM+47q8=";
    fetchSubmodules = true;
  };

  mesonFlags = [
    "-Dappend_libdir_mangohud=false"
    "-Duse_system_vulkan=enabled"
    "-Dwith_xnvctrl=disabled"
    "--libdir=${libdir}"
  ];

  buildInputs = [
    dbus
    glslang
    libglvnd
    mesa
    python3Packages.Mako
    vulkan-headers
    vulkan-loader
    xorg.libX11
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3Packages.Mako
    python3Packages.python
  ];

  preConfigure = ''
    mkdir -p "$out/share/vulkan/"
    ln -sf "${vulkan-headers}/share/vulkan/registry/" $out/share/vulkan/
    ln -sf "${vulkan-headers}/include" $out
  '';

  postInstall = ''
    ln -sf "${nvidia_x11}/lib/libnvidia-ml.so" $out/${libdir}/libnvidia-ml.so.1
    substituteInPlace $out/bin/mangohud --replace "\\\$LIB" "${libdir}"
    substituteInPlace $out/share/vulkan/implicit_layer.d/MangoHud.json --replace "\\\$LIB" "${libdir}"
    ${lib.optionalString stdenv.is32bit
      ''
        mv $out/bin/mangohud $out/bin/mangohud_32
        mv $out/share/vulkan/implicit_layer.d/MangoHud.json $out/share/vulkan/implicit_layer.d/MangoHud.x86.json
      ''
    }
  '';

  meta = with lib; {
    description = "A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more";
    homepage = "https://github.com/flightlessmango/MangoHud";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with maintainers; [ Technical27 ];
  };
}
