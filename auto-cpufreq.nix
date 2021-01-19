{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "auto-cpufreq";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "Technical27";
    repo = pname;
    rev = "2fb43b0df7cff3fe687c8a8447838fe4d1f6d093";
    sha256 = "sha256-gyRfYF4yOMbufmer11XjsaWK/RDBu+fYyvcsMY0h4tw=";
  };

  doCheck = false;
  pythonImportsCheck = [ "source" ];

  propagatedBuildInputs = with python3Packages; [ click distro psutil ];

  patches = [ ./prevent-install-and-copy.patch ];

  postInstall = ''
    cp ${src}/scripts/cpufreqctl.sh $out/bin/cpufreqctl
  '';
}
