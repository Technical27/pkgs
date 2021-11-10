{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    cargo
    rustc
    libnl
    dbus
    pkg-config
    rustfmt
  ];
}
