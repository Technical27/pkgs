{ lib, pythonPackages, fetchFromGitHub }:
with pythonPackages;

buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "AdnanHodzic";
    repo = pname;
    rev = "v${version}";
    sha256 = "18wvr4abnsiz1v96c7b1c4r30iq0d7rpx3js0apy1kv5wgbcxgfj";
  };

  propagatedBuildInputs = [ click distro psutil ];

  patches = [ ./auto-cpufreq.patch ];

  postInstall = ''
    cp ${src}/scripts/cpufreqctl.sh $out/bin/cpufreqctl
  '';
}
