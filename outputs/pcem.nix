{ stdenv
, lib
, fetchFromGitHub
, wxGTK31
, coreutils
, SDL2
, openal
, alsa-lib
, pkg-config
, cmake
, libpcap
}:

stdenv.mkDerivation rec {
  pname = "pcem";
  version = "unstable-2022-02-15";

  src = fetchFromGitHub {
    owner = "sarah-walker-pcem";
    repo = pname;
    rev = "1905187597c69798e70525d374e938609f296bf3";
    sha256 = "sha256-0aXsN0D3XATmWW6uNzx7d2UiD3zHHk4XXFIwrozkVvg=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [ wxGTK31 coreutils SDL2 openal alsa-lib libpcap ];

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" "-DUSE_NETWORKING=ON" "-DUSE_PCAP_NETWORKING=ON" "-DUSE_ALSA=ON" ];

  meta = with lib; {
    description = "Emulator for IBM PC computers and clones";
    homepage = "https://pcem-emulator.co.uk/";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.terin ];
    platforms = platforms.linux ++ platforms.windows;
  };
}
