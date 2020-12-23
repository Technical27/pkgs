{ appimageTools, lib, fetchurl }:

let
  pname = "mcbedrock";
  version = "2020-04-17";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/appimage/Minecraft_Bedrock_Launcher-x86_64.0.0.540.AppImage";
    sha256 = "0v1xnk4b7hy7dm3qgq9jsqihsh2lp6sl6axvdcndsv37kxwng2qj";
  };

  appimageContents = appimageTools.extract { inherit name src; };
in appimageTools.wrapType2 {
  inherit name src;
}
