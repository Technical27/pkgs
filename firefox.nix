{ wrapFirefox, firefox-unwrapped, fetchFirefoxAddon }:

wrapFirefox firefox-unwrapped {
  extraExtensions = [
    (fetchFirefoxAddon {
      name = "ublock-origin";
      url = "https://addons.mozilla.org/firefox/downloads/file/3679754/ublock_origin-1.31.0-an+fx.xpi";
      sha256 = "1h768ljlh3pi23l27qp961v1hd0nbj2vasgy11bmcrlqp40zgvnr";
    })
    (fetchFirefoxAddon {
      name = "lastpass";
      url = "https://addons.mozilla.org/firefox/downloads/file/3657084/lastpass_password_manager-4.58.0.4-an+fx.xpi";
      sha256 = "0dbkmhya5lpdphssnd966xsfplzv1nmbq6sfdqg0rklgk61rscvf";
    })
    (fetchFirefoxAddon {
      name = "https-everywhere";
      url = "https://addons.mozilla.org/firefox/downloads/file/3679479/https_everywhere-2020.11.17-an+fx.xpi";
      sha256 = "1jc5wccmjiaa2q1fhbnfilzz39pd68w5n2zwm7km8zk00l5cpsx6";
    })
    (fetchFirefoxAddon {
      name = "vuejs-devtools";
      url = "https://addons.mozilla.org/firefox/downloads/file/3454607/vuejs_devtools-5.3.3-fx.xpi";
      sha256 = "06ycn1bj00dh9klwg7bz23psgszcd02xp3668kfwvbbz9nnvvnsk";
    })
  ];
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
  };
}
