{ lib
, stdenv
, fetchFromGitHub
, fetchurl
, substituteAll
, coreutils
, curl
, gawk
, glxinfo
, gnugrep
, gnused
, lsof
, xdg-utils
, dbus
, hwdata
, libX11
, mangohud32
, vulkan-headers
, glslang
, makeWrapper
, meson
, ninja
, pkg-config
, python3Packages
, unzip
, vulkan-loader
, libXNVCtrl
, wayland
, mesa
, addOpenGLRunpath
}:

let
  # Derived from subprojects/imgui.wrap
  imgui = rec {
    version = "1.81";
    src = fetchFromGitHub {
      owner = "ocornut";
      repo = "imgui";
      rev = "v${version}";
      hash = "sha256-rRkayXk3xz758v6vlMSaUu5fui6NR8Md3njhDB0gJ18=";
    };
    patch = fetchurl {
      url = "https://wrapdb.mesonbuild.com/v2/imgui_${version}-1/get_patch";
      hash = "sha256-bQC0QmkLalxdj4mDEdqvvOFtNwz2T1MpTDuMXGYeQ18=";
    };
  };

  spdlog = rec {
    version = "1.8.5";
    src = fetchFromGitHub {
      owner = "gabime";
      repo = "spdlog";
      rev = "v${version}";
      hash = "sha256-D29jvDZQhPscaOHlrzGN1s7/mXlcsovjbqYpXd7OM50=";
    };
    patch = fetchurl {
      url = "https://wrapdb.mesonbuild.com/v2/spdlog_1.8.5-1/get_patch";
      hash = "sha256-PDjyddV5KxKGORECWUMp6YsXc3kks0T5gxKrCZKbdL4=";
    };
  };
in
stdenv.mkDerivation rec {
  pname = "mangohud";
  version = "0.6.6";

  src = fetchFromGitHub {
    owner = "flightlessmango";
    repo = "MangoHud";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-T2CQEkSYn9w6+6ERgx0GRg4pwQA14jFEqiXLQZOhaUg=";
  };

  outputs = [ "out" "doc" "man" ];

  # Unpack subproject sources
  postUnpack = ''(
    cd "$sourceRoot/subprojects"
    cp -R --no-preserve=mode,ownership ${imgui.src} imgui-${imgui.version}
    unzip ${imgui.patch}
    cp -R --no-preserve=mode,ownership ${spdlog.src} spdlog-${spdlog.version}
    unzip ${spdlog.patch}
  )'';

  patches = [
    # Hard code dependencies. Can't use makeWrapper since the Vulkan
    # layer can be used without the mangohud executable by setting MANGOHUD=1.
    (substituteAll {
      src = ./hardcode-dependencies.patch;

      path = lib.makeBinPath [
        coreutils
        curl
        gawk
        glxinfo
        gnugrep
        gnused
        lsof
        xdg-utils
      ];

      libdbus = dbus.lib;
      inherit hwdata libX11;
    })
  ] ++ lib.optional (stdenv.hostPlatform.system == "x86_64-linux") [
    # Support 32bit OpenGL applications by appending the mangohud32
    # lib path to LD_LIBRARY_PATH.
    #
    # This workaround is necessary since on Nix's build of ld.so, $LIB
    # always expands to lib even when running an 32bit application.
    #
    # See https://github.com/NixOS/nixpkgs/issues/101597.
    (substituteAll {
      src = ./opengl32-nix-workaround.patch;
      inherit mangohud32;
    })
  ];

  mesonFlags = [
    "-Duse_system_vulkan=enabled"
    "-Dvulkan_datadir=${vulkan-headers}/share"
    "-Dwith_wayland=enabled"
  ];

  nativeBuildInputs = [
    glslang
    makeWrapper
    meson
    ninja
    pkg-config
    python3Packages.Mako
    python3Packages.python
    unzip
    vulkan-loader
  ];

  buildInputs = [
    dbus
    mesa
    libX11
    libXNVCtrl
    wayland
  ];

  # Support 32bit Vulkan applications by linking in 32bit Vulkan layer
  # This is needed for the same reason the 32bit OpenGL workaround is needed.
  postInstall = lib.optionalString (stdenv.hostPlatform.system == "x86_64-linux") ''
    ln -s ${mangohud32}/share/vulkan/implicit_layer.d/MangoHud.json \
      "$out/share/vulkan/implicit_layer.d/MangoHud.x86.json"
  '';

  # Support Nvidia cards by adding OpenGL path and support overlaying
  # Vulkan applications without requiring MangoHud to be installed
  postFixup = ''
    wrapProgram "$out/bin/mangohud" \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ addOpenGLRunpath.driverLink ]} \
      --prefix XDG_DATA_DIRS : "$out/share"
  '';

  meta = with lib; {
    description = "A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more";
    homepage = "https://github.com/flightlessmango/MangoHud";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = with maintainers; [ kira-bruneau zeratax ];
  };
}
