{ stdenv
, lib
, fetchFromGitHub
, meson
, ninja
, xorg
, libdrm
, vulkan-headers
, wayland
, wayland-protocols
, libxkbcommon
, SDL2
, libcap
, glslang
, vulkan-loader
, libliftoff
, pkg-config
, mesa
, libinput
, pixman
, cairo
, libuuid
, xwayland
, wayland-scanner
, libGL
}:

let
  wlroots = fetchFromGitHub {
    owner = "swaywm";
    repo = "wlroots";
    rev = "0.13.0";
    sha256 = "01plhbnsp5yg18arz0v8fr0pr9l4w4pdzwkg9px486qdvb3s1vgy";
  };
  libliftoff = fetchFromGitHub {
    owner = "emersion";
    repo = "libliftoff";
    rev = "v0.1.0";
    sha256 = "1s53jsll3c7272bhmh4jr6k5m1nvn8i1ld704qmzsm852ilmgrla";
  };
in
stdenv.mkDerivation {
  name = "gamescope";
  version = "unstable-2021-08-20";

  src = fetchFromGitHub {
    owner = "Plagman";
    repo = "gamescope";
    rev = "7bdb4555ff3ad76633033726baf54e668bb820ce";
    sha256 = "sha256-BzlGlXCTwPm0VmXdskgcRY0ghwTwL7IOmX651D59vTw=";
    # fetchSubmodules = true;
    # deepClone = true;
  };

  nativeBuildInputs = [ meson ninja pkg-config pixman cairo wayland-scanner ];

  buildInputs = [
    xorg.libX11
    xorg.libXdamage
    xorg.libXcomposite
    xorg.libXrender
    xorg.libXext
    xorg.libXfixes
    xorg.libXxf86vm
    xorg.libXtst
    xorg.libXres
    xorg.xinput
    xorg.xcbutilwm
    xorg.xcbutilerrors
    xorg.xcbutilrenderutil
    xorg.libXi
    vulkan-loader
    vulkan-headers
    libGL
    libdrm
    wayland
    wayland-protocols
    libxkbcommon
    SDL2
    libcap
    glslang
    mesa
    libinput
    libuuid
    xwayland
  ];

  patches = [ ./fix-wlroots.patch ];

  preConfigure = ''
    cp -r ${wlroots}/* subprojects/wlroots/
    cp -r ${libliftoff}/* subprojects/libliftoff/
  '';

  postInstall = ''
    rm -r $out/include
  '';
}
