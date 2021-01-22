{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "f47c65acc9a2ae02495d455d00f895fc26fb451f";
    sha256 = "sha256-mziOPMoqcoNZD7XIN+6l5LcWK7vGDmP5NjoeHZWunkg=";
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
