{ pkgs }:

let
  scan-build = pkgs.python3Packages.callPackage ./scan-build.nix {};
  cobs = pkgs.python3Packages.callPackage ./cobs.nix {};
  rfc6266-parser = pkgs.python3Packages.callPackage ./rfc6266.nix { inherit lepl; };
  observable = pkgs.python3Packages.callPackage ./observable.nix {};
  pypng = pkgs.python3Packages.callPackage ./pypng.nix {};
  lepl = pkgs.python3Packages.callPackage ./lepl.nix {};
  click = pkgs.python3Packages.callPackage ./click.nix {};
in pkgs.callPackage ./cli.nix { inherit cobs scan-build rfc6266-parser observable pypng click; }
