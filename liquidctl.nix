{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonApplication rec {
  pname = "liquidctl";
  version = "v1.4.2";

  src = fetchFromGitHub {
    repo = "liquidctl";
    owner = "jonasmalacofilho";
    rev = version;
    sha256 = "1h5kqpvlx7xppd2wli986lkslqkcrlz1wixv7fvrppzjc2nfz5d4";
  };

  propagatedBuildInputs = with python3Packages; [ pyusb docopt hidapi ];
}
