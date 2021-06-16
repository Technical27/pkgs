{ wrapFirefox, firefox-unwrapped, fetchFirefoxAddon }:

wrapFirefox firefox-unwrapped {
  nixExtensions = let
    ff-extensions = builtins.fromJSON (builtins.readFile ./firefox-src.json);
  in builtins.map (e: fetchFirefoxAddon { inherit (e) name sha256 url; }) ff-extensions;
  extraPolicies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = false;
    FirefoxHome = {
      Pocket = false;
      Snippets = false;
    };
    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
    DisableSetDesktopBackground = true;
  };
}
