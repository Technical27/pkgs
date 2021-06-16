{ fetchFromGitHub, vimUtils }:

vimUtils.buildVimPlugin rec {
  pname = "telescope-coc";
  version = "2021-06-16";
  src = fetchFromGitHub {
    owner = "fannheyward";
    repo = "telescope-coc.nvim";
    rev = "master";
    sha256 = "sha256-pOlmuaGM8vSSdwnmpUgVch9FZ5Mpn/IlH3QGKy4L7AY=";
  };
}
