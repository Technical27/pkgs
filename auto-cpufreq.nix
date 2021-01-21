{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "36e7073ff438136f19cec55e106020125f0a6f97";
    sha256 = "sha256-qmFq2AVwNj3NpN010r1Pn+TG1CzdcgSm/Ii8NAzY/K0=";
  };

  doCheck = false;
  pythonImportsCheck = [ "auto_cpufreq" ];

  propagatedBuildInputs = with python3Packages; [ click distro psutil ];

  patches = [ ./prevent-install-and-copy.patch ];

  postInstall = ''
    cp ${src}/scripts/cpufreqctl.sh $out/bin/cpufreqctl.auto-cpufreq

    mkdir -p $out/lib/systemd/system
    cp ${src}/scripts/auto-cpufreq.service $out/lib/systemd/system
    substituteInPlace $out/lib/systemd/system/auto-cpufreq.service --replace "/usr/local" $out
  '';
}
