{ pkgs ? import <nixpkgs> {} }:

{
  firefox-with-extensions = import ./firefox.nix {
    inherit (pkgs) wrapFirefox firefox-unwrapped fetchFirefoxAddon;
  };
  context-vim = pkgs.callPackage ./context-vim.nix { inherit pkgs; };
  glfw-wayland = pkgs.callPackage ./glfw.nix {};
  gruvbox-gtk = pkgs.callPackage ./gruvbox-gtk.nix {};
  gruvbox-icons = pkgs.callPackage ./gruvbox-icons.nix {};
}
