{ fetchFromGitHub, vimUtils }:

vimUtils.buildVimPlugin rec {
  pname = "colorbuddy.nvim";
  version = "20201-02-14";
  src = fetchFromGitHub {
    owner = "tjdevries";
    repo = pname;
    rev = "master";
    sha256 = "sha256-cEzT9RhE+voYgwY53xjNH5j88Uk+L/DmIDsFMN5plm8=";
  };
}
