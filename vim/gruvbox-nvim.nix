{ fetchFromGitHub, vimUtils }:

vimUtils.buildVimPlugin rec {
  pname = "gruvbox.nvim";
  version = "20201-02-14";
  src = fetchFromGitHub {
    owner = "npxbr";
    repo = pname;
    rev = "main";
    sha256 = "sha256-f6ufts5tZtYj2e6UZ6T5eJBeGtW2bQuRtbn+2bpx47Q=";
  };
}
