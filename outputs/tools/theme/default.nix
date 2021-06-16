{ python3Packages }:

python3Packages.buildPythonPackage {
  pname = "theme";
  version = "0.0.0";

  src = ./.;

  propagatedBuildInputs = with python3Packages; [
    pynvim
    psutil
  ];

  doCheck = false;
}
