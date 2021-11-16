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
      version = "6.19";
      url = "https://dl.winehq.org/wine/source/6.x/wine-${version}.tar.xz";
      sha256 = "sha256-QYLi2WJ3BMw3b0b8MQlYDqkHd5b0T17oPgjj6Wvwq2Y=";

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

      patches = [
        # Also look for root certificates at $NIX_SSL_CERT_FILE
        ./cert-path.patch
      ];
    };

    patch = fetchFromGitHub rec {
      inherit (src) version;
      sha256 = "sha256-1Ng+kFFnqEndlCvI0eG1YmyqPdcolD3cVJ2KU5GU7Z4=";
      owner = "wine-staging";
      repo = "wine-staging";
      rev = "v${version}";

      disabledPatchsets = [ ];
    };

    patches = self.patches ++ [
      ./patches/childwindow.patch
      ./patches/wayland.patch
    ];
  })
