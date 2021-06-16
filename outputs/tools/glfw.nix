{ stdenv, fetchFromGitHub, cmake, extra-cmake-modules, lib
, libxkbcommon, wayland, wayland-protocols, libGL
}:

stdenv.mkDerivation rec {
  version = "3.3.2";
  pname = "glfw-wayland";

  src = fetchFromGitHub {
    owner = "glfw";
    repo = "GLFW";
    rev = version;
    sha256 = "0b5lsxz1xkzip7fvbicjkxvg5ig8gbhx1zrlhandqc0rpk56bvyw";
  };

  preConfigure = ''
    substituteInPlace src/egl_context.c --replace "libGL.so.1" "${lib.getLib libGL}/lib/libGL.so.1"
    substituteInPlace src/egl_context.c --replace "libEGL.so.1" "${lib.getLib libGL}/lib/libEGL.so.1"
    substituteInPlace src/wl_init.c --replace "libxkbcommon.so.0" "${lib.getLib libxkbcommon}/lib/libxkbcommon.so.0"
  '';

  enableParallelBuilding = true;

  propagatedBuildInputs = [ libGL ];

  nativeBuildInputs = [ cmake extra-cmake-modules wayland-protocols ];

  buildInputs = [ wayland libxkbcommon ];

  cmakeFlags = [ "-DBUILD_SHARED_LIBS=ON" "-DGLFW_USE_WAYLAND=ON" ];
}
