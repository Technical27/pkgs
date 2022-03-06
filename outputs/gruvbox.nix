{ icons ? false
, stdenv
, fetchFromGitHub
}:

let
  type = if icons then "icons" else "theme";
in
stdenv.mkDerivation rec {
  pname = "gruvbox-dark-${type}";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = "gruvbox";
    rev = "master";
    sha256 = "sha256-c8/U24KOBWv49tdjrc26IzpEfxL5ZlMSZrc7OQcbPks=";
  };

  installPhase =
    let
      dir = if icons then "icons" else "themes";
    in
    ''
      mkdir -p $out/share/${dir}
      cp -r ${src}/dark/${type} $out/share/${dir}/gruvbox-dark
    '';

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  dontBuild = true;
  dontFixup = true;
}
