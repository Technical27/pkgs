{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "bd40bc98ff82a5042e34b34a7e488f52a66de373";
    sha256 = "sha256-ovQWi3n1OmI5JWNWkSTTdf5hukO3f8/ol7m8JHYrL7w=";
  };

  doCheck = false;
  pythonImportsCheck = [ "source" ];

  propagatedBuildInputs = with python3Packages; [ click distro psutil ];

  patches = [ ./prevent-install-and-copy-updated.patch ];

  postInstall = ''
    cp ${src}/scripts/cpufreqctl.sh $out/bin/cpufreqctl
  '';
}
