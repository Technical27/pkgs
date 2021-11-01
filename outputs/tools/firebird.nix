{ mkDerivation, lib, fetchFromGitHub, qmake, qtbase, qtdeclarative }:

mkDerivation rec {
  pname = "firebird-emu";
  version = "unstable-2021-10-21";

  src = fetchFromGitHub {
    owner = "nspire-emus";
    repo = "firebird";
    rev = "4c3a83375b12d7cd31463bba9f1a35449cbb4f50";
    sha256 = "sha256-oWiWITr9S2DDzqO96z9a1H7neYtUVEAvwxx1wKo1r+Q=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ qmake ];

  buildInputs = [ qtbase qtdeclarative ];

  makeFlags = [ "INSTALL_ROOT=$(out)" ];

  # Attempts to install to /usr/bin and /usr/share/applications, which Nix does
  # not use.
  prePatch = ''
    substituteInPlace firebird.pro \
      --replace '/usr/' '/'
  '';

  meta = {
    homepage = "https://github.com/nspire-emus/firebird";
    description = "Third-party multi-platform emulator of the ARM-based TI-Nspire™ calculators";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ pneumaticat ];
    # Only tested on Linux, but likely possible to build on, e.g. macOS
    platforms = lib.platforms.linux;
  };
}
