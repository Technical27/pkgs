{ pkgs ? import <nixpkgs> {} }:

{
  firefox-with-extensions = pkgs.callPackage ./firefox.nix {};
  context-vim = pkgs.callPackage ./context-vim.nix {};
  glfw-wayland = pkgs.callPackage ./glfw.nix {};
  gruvbox-gtk = pkgs.callPackage ./gruvbox-gtk.nix {};
  gruvbox-icons = pkgs.callPackage ./gruvbox-icons.nix {};
}
