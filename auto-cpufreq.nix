{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "AdnanHodzic";
    repo = pname;
    rev = "v${version}";
    sha256 = "09zkq74cz73hkzirhlsyq9b3kgbd10i7r033mid59lc2dz20wvc4";
  };

  propagatedBuildInputs = with python3Packages; [ click distro psutil ];

  patches = [ ./prevent-install-and-copy.patch ];

  postInstall = ''
    cp ${src}/scripts/cpufreqctl.sh $out/bin/cpufreqctl
  '';
}
