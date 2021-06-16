{ darkTheme ? false,
  icons ? false,
  stdenv,
  fetchFromGitHub
}:

let
  varient = if darkTheme then "dark" else "light";
  type = if icons then "icons" else "theme";
in stdenv.mkDerivation rec {
  pname = "gruvbox-${varient}-${type}";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = "gruvbox";
    rev = "master";
    sha256 = "sha256-c8/U24KOBWv49tdjrc26IzpEfxL5ZlMSZrc7OQcbPks=";
  };

  installPhase = let
    dir = if icons then "icons" else "themes";
  in ''
    mkdir -p $out/share/${dir}
    cp -r ${src}/${varient}/${type} $out/share/${dir}/gruvbox-${varient}
  '';

  dontFixup = true;
}
