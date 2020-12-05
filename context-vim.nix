{ pkgs }:

pkgs.vimUtils.buildVimPlugin rec {
  pname = "context";
  version = "2020-11-02";
  src = pkgs.fetchFromGitHub {
    owner = "wellle";
    repo = "context.vim";
    rev = "master";
    sha256 = "1iy614py9qz4rwk9p4pr1ci0m1lvxil0xiv3ymqzhqrw5l55n346";
  };
}
