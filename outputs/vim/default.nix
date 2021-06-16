{ fetchFromGitHub, vimUtils }:

{
  telescope-coc = import ./telescope-coc.nix { inherit fetchFromGitHub vimUtils; };
  context-vim = import ./context-vim.nix { inherit fetchFromGitHub vimUtils; };
}
