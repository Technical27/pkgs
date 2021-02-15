{ callPackage }:

{
  context-vim     = callPackage ./context-vim.nix     {};
  gruvbox-nvim    = callPackage ./gruvbox-nvim.nix    {};
  colorbuddy-nvim = callPackage ./colorbuddy-nvim.nix {};
}
