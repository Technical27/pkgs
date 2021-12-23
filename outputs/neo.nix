{ stdenv, lib, fetchFromGitHub, autoreconfHook, ncurses }:

stdenv.mkDerivation rec {
  pname = "neo";
  version = "unstable-2021-12-22";

  src = fetchFromGitHub {
    owner = "st3w";
    repo = pname;
    rev = "bd5491fdfa62258b5e3952619846b4b53eda4f11";
    sha256 = "sha256-HRgDqo7BRbDyq3hFH8DotssfHcB+l/DISS/nZgbtBD8=";
  };

  buildInputs = [ ncurses ];
  nativeBuildInputs = [ autoreconfHook ];
}
