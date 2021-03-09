{ python3Packages }:

python3Packages.buildPythonPackage {
  pname = "theme";
  version = "0.0.0";

  src = ./.;

  propagatedBuildInputs = [
    python3Packages.pynvim
  ];

  doCheck = false;
}
