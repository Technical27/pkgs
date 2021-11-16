{ wineWowPackages, lib, pkgs }:

lib.overrideDerivation wineWowPackages.stagingFull (self:
  let
    fetchurl = args@{ url, sha256, ... }:
      pkgs.fetchurl { inherit url sha256; } // args;
    fetchFromGitHub = args@{ owner, repo, rev, sha256, ... }:
      pkgs.fetchFromGitHub { inherit owner repo rev sha256; } // args;
  in
  rec {
    src = fetchurl rec {
      version = "6.17";
      url = "https://dl.winehq.org/wine/source/6.x/wine-${version}.tar.xz";
      sha256 = "sha256-nbHyQ12AJiw3dzF98HWFWu6j5qUst3xjDsGysfuUjwg=";

      gecko32 = fetchurl rec {
        version = "2.47.1";
        url = "https://dl.winehq.org/wine/wine-gecko/${version}/wine-gecko-${version}-x86.msi";
        sha256 = "0ld03pjm65xkpgqkvfsmk6h9krjsqbgxw4b8rvl2fj20j8l0w2zh";
      };

      gecko64 = fetchurl rec {
        version = "2.47.1";
        url = "https://dl.winehq.org/wine/wine-gecko/${version}/wine-gecko-${version}-x86_64.msi";
        sha256 = "0jj7azmpy07319238g52a8m4nkdwj9g010i355ykxnl8m5wjwcb9";
      };

      mono = fetchurl rec {
        version = "6.3.0";
        url = "https://dl.winehq.org/wine/wine-mono/${version}/wine-mono-${version}-x86.msi";
        sha256 = "sha256-pfAtMqAoNpKkpiX1Qc+7tFGIMShHTFyANiOFMXzQmfA=";
      };

      patches = [
        # Also look for root certificates at $NIX_SSL_CERT_FILE
        ./cert-path.patch
      ];
    };

    patch = fetchFromGitHub rec {
      inherit (src) version;
      sha256 = "sha256-rR5m6D8M3vTXXIHzsF8+o2G5rlRS2HLfCHoatbJwlrQ=";
      owner = "wine-staging";
      repo = "wine-staging";
      rev = "v${version}";

      disabledPatchsets = [ ];
    };

    postPatch = ''
      patchShebangs tools
      cp -r ${patch}/patches .
      chmod +w patches
      cd patches
      patchShebangs gitapply.sh
      ./patchinstall.sh DESTDIR="$PWD/.." --all ${lib.concatMapStringsSep " " (ps: "-W ${ps}") patch.disabledPatchsets}
      cd ..
    '';

    patches = self.patches ++ [
      ./patches/childwindow.patch
      ./patches/wayland.patch
    ];
  })
