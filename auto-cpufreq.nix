{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "cb6ac6ad076fb6fca21acf30c2467d372e6ca077";
    sha256 = "sha256-8rYNu/SP82YQ5YOb1qgP55wDFBZK4eiisRSjywcQCjg=";
  };

  doCheck = false;
  pythonImportsCheck = [ "auto_cpufreq" ];

  propagatedBuildInputs = with python3Packages; [ click distro psutil ];

  patches = [ ./prevent-install-and-copy.patch ];

  postInstall = ''
    cp ${src}/scripts/cpufreqctl.sh $out/bin/cpufreqctl.auto-cpufreq

    mkdir -p $out/lib/systemd/system
    cp ${src}/scripts/auto-cpufreq.service $out/lib/systemd/system
  '';
}
